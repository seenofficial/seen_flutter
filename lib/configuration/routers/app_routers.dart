import 'package:enmaa/features/authentication_module/presentation/screens/bio_metric_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/login_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/otp_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/sign_up_screen.dart';
import 'package:enmaa/features/book_property/presentation/screens/book_property_main_screen.dart';
import 'package:enmaa/features/home_module/presentation/controller/home_bloc.dart';
import 'package:enmaa/features/home_module/presentation/screens/home_screen.dart';
import 'package:enmaa/features/my_profile/modules/user_appointments/presentation/controller/user_appointments_cubit.dart';
import 'package:enmaa/features/my_profile/modules/user_appointments/presentation/screens/user_appointments_screen.dart';
import 'package:enmaa/features/my_profile/modules/user_appointments/user_appointments_DI.dart';
import 'package:enmaa/features/my_profile/modules/user_properties_module/presentation/screens/user_properties_screen.dart';
import 'package:enmaa/features/my_profile/modules/user_properties_module/user_properties_DI.dart';
import 'package:enmaa/features/preview_property/presentation/screens/preview_property_main_screen.dart';
import 'package:enmaa/features/preview_property/preview_property_DI.dart';
import 'package:enmaa/features/real_estates/presentation/screens/real_estate_details_screen.dart';
import 'package:enmaa/features/splash_and_on_boarding/screens/on_boarding_screen.dart';
import 'package:enmaa/features/wallet/presentation/controller/wallet_cubit.dart';
import 'package:enmaa/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/service_locator.dart';
import '../../features/add_new_real_estate/presentation/screens/add_new_real_estate_screen.dart';
import '../../features/authentication_module/authentication_flow_navigator.dart';
import '../../features/authentication_module/presentation/controller/biometric_bloc.dart';
import '../../features/authentication_module/presentation/controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import '../../features/my_profile/modules/user_properties_module/presentation/controller/user_properties_cubit.dart';
import '../../features/preview_property/presentation/controller/preview_property_cubit.dart';
import '../../features/wallet/presentation/screens/charge_wallet_screen.dart';
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
            create: (context) {
              if (ServiceLocator.getIt.isRegistered<HomeBloc>()) {
                final bloc = ServiceLocator.getIt<HomeBloc>();
                if (bloc.isClosed) {
                  ServiceLocator.getIt.unregister<HomeBloc>();
                }
              }

              if (!ServiceLocator.getIt.isRegistered<HomeBloc>()) {
                ServiceLocator.getIt.registerLazySingleton<HomeBloc>(
                      () => HomeBloc(
                        ServiceLocator.getIt(),
                        ServiceLocator.getIt(),
                        ServiceLocator.getIt(),
                  ),
                );
              }

              return ServiceLocator.getIt<HomeBloc>()
                ..add(FetchBanners())
                ..add(FetchAppServices());
            },
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
        case RoutersNames.myPropertiesScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.myPropertiesScreen),
          builder: (_) => BlocProvider(
            create: (context){
              UserPropertiesDi().setup();

              return UserPropertiesCubit(
                ServiceLocator.getIt(),
              ) ;
            },
            child: const MyPropertiesScreen(),
          ),
        );
case RoutersNames.userAppointmentsScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.userAppointmentsScreen),
          builder: (_) => BlocProvider(
            create: (context){
              UserAppointmentsDi().setup();
              return UserAppointmentsCubit(
                ServiceLocator.getIt(),
              ) ;
            },
            child: const UserAppointmentsScreen(),
          ),
        );

      case RoutersNames.realEstateDetailsScreen:
        final args = (settings.arguments as int).toString() ;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.realEstateDetailsScreen),
          builder: (_) => RealEstateDetailsScreen(propertyId: args),
        );

      case RoutersNames.addNewRealEstateScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.addNewRealEstateScreen),
          builder: (_) => const AddNewRealEstateScreen(),
        );
        case RoutersNames.bookPropertyScreen:
          final args = settings.arguments ;
          final String propertyId = args as String ;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.bookPropertyScreen),
          builder: (_) => BookPropertyMainScreen(
            propertyId: propertyId,
          ),
        );

      case RoutersNames.onBoardingScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.onBoardingScreen),
          builder: (_) => const OnBoardingScreen(),
        );
      case RoutersNames.authenticationFlow:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.authenticationFlow),
          builder: (_) => const AuthenticationNavigator(),
        );
        case RoutersNames.chargeWalletScreen:
          final args = settings.arguments ;
          final WalletCubit walletCubit = args as WalletCubit ;

        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.chargeWalletScreen),
          builder: (_) =>   ChargeWalletScreen(
            walletCubit: walletCubit,
          ),
        );
      case RoutersNames.previewPropertyScreen:
        final args = settings.arguments ;
        final String propertyId = args as String ;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutersNames.previewPropertyScreen),
          builder: (_) => BlocProvider(
            create: (context) {

              PreviewPropertyDi().setup() ;
              return PreviewPropertyCubit(
                ServiceLocator.getIt(),
                ServiceLocator.getIt(),
                ServiceLocator.getIt(),
              ) ;
            },
            child: PreviewPropertyScreen(propertyId: propertyId,),
          ),
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
