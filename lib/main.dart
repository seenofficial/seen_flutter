
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/features/real_estates/presentation/controller/filter_properties_controller/filter_property_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'configuration/routers/app_routers.dart';
import 'configuration/routers/route_names.dart';
import 'core/services/bio_metric_service.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/navigator_observer.dart';
import 'core/services/service_locator.dart';
import 'core/translation/codegen_loader.g.dart';
import 'features/real_estates/presentation/controller/real_estate_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    setupServiceLocator(),
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    ),
  ]);

  Bloc.observer = MyBlocObserver();

   HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path)
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),  // load translation assets files
      fallbackLocale: Locale('en'),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: BlocProvider(
  create: (context) => FilterPropertyCubit(),
  child: MaterialApp(
        navigatorObservers: [RouteObserverService()],
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: const Locale('ar'),
        theme: ThemeData(
          fontFamily: context.locale == const Locale('en') ? 'Cairo' : 'Cairo',
          visualDensity: Platform.isIOS ? VisualDensity.standard : VisualDensity.adaptivePlatformDensity, // Adjust for iOS
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // iOS-style transition
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(), // Android default
            },
          ),
          cupertinoOverrideTheme:  CupertinoThemeData(
            primaryColor: ColorManager.primaryColor, // Customize iOS theme if needed
          ),
        ),
        onGenerateRoute: AppRouters().generateRoute,
        initialRoute: RoutersNames.biometricScreen,
      ),
),
    );
  }
}


