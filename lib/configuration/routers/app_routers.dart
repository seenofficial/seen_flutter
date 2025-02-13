import 'package:enmaa/features/authentication_module/presentation/screens/bio_metric_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/login_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/sign_up_screen.dart';
import 'package:enmaa/features/home_module/presentation/controller/home_bloc.dart';
import 'package:enmaa/features/home_module/presentation/screens/home_screen.dart';
import 'package:enmaa/features/real_estates/presentation/screens/real_estate_details_screen.dart';
import 'package:enmaa/features/splash_and_on_boarding/screens/on_boarding_screen.dart';
import 'package:enmaa/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/service_locator.dart';
import '../../features/add_new_real_estate/presentation/screens/add_new_real_estate_screen.dart';
import '../../features/authentication_module/presentation/controller/biometric_bloc.dart';
import '../../features/authentication_module/presentation/controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import 'route_names.dart';
import '../../core/screens/splash_screen.dart';

class AppRouters {
  AppRouters();

  static final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutersNames.splash:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.splash),
          builder: (_) => const SplashScreen(),
        );

      case RoutersNames.layoutScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.layoutScreen),
          builder: (_) => BlocProvider(
            create: (context) => ServiceLocator.getIt<HomeBloc>()
              ..add(FetchBanners())
              ..add(FetchAppServices()),
            child: const LayoutScreen(initialIndex: 0),
          ),
        );

      case RoutersNames.biometricScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.biometricScreen),
          builder: (_) => BlocProvider(
            create: (context) => BiometricBloc(ServiceLocator.getIt()),
            child: const BioMetricScreen(),
          ),
        );

      case RoutersNames.realEstateDetailsScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.realEstateDetailsScreen),
          builder: (_) => const RealEstateDetailsScreen(),
        );

      case RoutersNames.addNewRealEstateScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.addNewRealEstateScreen),
          builder: (_) => const AddNewRealEstateScreen(),
        );

      case RoutersNames.onBoardingScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.onBoardingScreen),
          builder: (_) => const OnBoardingScreen(),
        );
      case RoutersNames.loginScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.loginScreen),
          builder: (_) => BlocProvider(
            create: (context) =>
                ServiceLocator.getIt<RemoteAuthenticationCubit>(),
            child: LoginScreen(),
          ),
        );
      case RoutersNames.signUpScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.signUpScreen),
          builder: (_) => SignUpScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
