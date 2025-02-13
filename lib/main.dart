
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: MaterialApp(
        navigatorObservers: [RouteObserverService()],
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: Locale('ar'),
        theme: ThemeData(
        fontFamily:
            context.locale == const Locale('en') ? 'Cairo' : 'Cairo'
        ),
        onGenerateRoute: AppRouters().generateRoute,
        initialRoute: RoutersNames.biometricScreen,
      ),
    );
  }
}


