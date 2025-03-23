import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:enmaa/features/real_estates/presentation/controller/filter_properties_controller/filter_property_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configuration/routers/app_routers.dart';
import 'configuration/routers/route_names.dart';
import 'core/components/custom_snack_bar.dart';
import 'core/services/bio_metric_service.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/navigator_observer.dart';
import 'core/services/service_locator.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/translation/codegen_loader.g.dart';
import 'features/my_profile/modules/user_appointments/presentation/controller/user_appointments_cubit.dart';
import 'features/my_profile/modules/user_appointments/user_appointments_DI.dart';
import 'features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'features/wish_list/domain/use_cases/add_new_property_to_wish_list_use_case.dart';
import 'features/wish_list/domain/use_cases/get_properties_wish_list_use_case.dart';
import 'features/wish_list/domain/use_cases/remove_property_from_wish_list_use_case.dart';
import 'features/wish_list/presentation/controller/wish_list_cubit.dart';
import 'features/wish_list/wish_list_DI.dart';
import 'firebase_options.dart';

bool isAuth = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    EasyLocalization.ensureInitialized(),
    setupServiceLocator(),
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    ),
  ]);

  Bloc.observer = MyBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:
          HydratedStorageDirectory((await getTemporaryDirectory()).path));

  await SharedPreferencesService().init();

  final prefs = await SharedPreferences.getInstance();
  var token = prefs.get('access_token');
  if (token != null) {
    isAuth = true;
  }

  bool isFirstLaunch = await SharedPreferencesService().isFirstLaunch();
  String initialRoute;
  if (isFirstLaunch) {
    initialRoute = RoutersNames.onBoardingScreen;
  } else if (token != null) {
    initialRoute = RoutersNames.biometricScreen;
  } else {
    initialRoute = RoutersNames.authenticationFlow;
  }

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(), // load translation assets files
      fallbackLocale: Locale('en'),
      child: MyApp(
        initialRoute: initialRoute,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FilterPropertyCubit(),
          ),
          BlocProvider(
            create: (context) =>
                SelectLocationServiceCubit.getOrCreate()..getCountries(),
          ),
          BlocProvider(
            create: (context) {
              UserAppointmentsDi().setup();
              return UserAppointmentsCubit(
                ServiceLocator.getIt(),
                ServiceLocator.getIt(),
                ServiceLocator.getIt(),
              );
            },
          ),
          BlocProvider(
            create: (context) {
              WishListDi().setup();
              return WishListCubit(
                ServiceLocator.getIt<GetPropertiesWishListUseCase>(),
                ServiceLocator.getIt<RemovePropertyFromWishListUseCase>(),
                ServiceLocator.getIt<AddNewPropertyToWishListUseCase>(),
              )..getPropertyWishList();
            },
          ),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: CustomSnackBar.scaffoldMessengerKey,
          navigatorObservers: [RouteObserverService()],
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: const Locale('ar'),
          theme: ThemeData(
            fontFamily:
                context.locale == const Locale('en') ? 'Cairo' : 'Cairo',
            visualDensity: Platform.isIOS
                ? VisualDensity.standard
                : VisualDensity.adaptivePlatformDensity, // Adjust for iOS
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.iOS:
                    CupertinoPageTransitionsBuilder(), // iOS-style transition
                TargetPlatform.android:
                    FadeUpwardsPageTransitionsBuilder(), // Android default
              },
            ),
            cupertinoOverrideTheme: CupertinoThemeData(
              primaryColor:
                  ColorManager.primaryColor, // Customize iOS theme if needed
            ),
          ),
          onGenerateRoute: AppRouters().generateRoute,
          initialRoute: initialRoute,
        ),
      ),
    );
  }
}
