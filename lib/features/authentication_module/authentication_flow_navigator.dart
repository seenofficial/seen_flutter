import 'package:enmaa/features/authentication_module/presentation/screens/create_new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:enmaa/features/authentication_module/presentation/controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import '../../configuration/routers/route_names.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/login_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/sign_up_screen.dart';
import 'package:enmaa/features/authentication_module/presentation/screens/otp_screen.dart';

import '../../core/services/navigator_observer.dart';

/// use this screen to navigate between login, sign up and otp screens
/// and to provide the authentication cubit to the screens
/// and make it alive  during the navigation
class AuthenticationNavigator extends StatelessWidget {
  const AuthenticationNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RemoteAuthenticationCubit(
        ServiceLocator.getIt(),
        ServiceLocator.getIt(),
        ServiceLocator.getIt(),
        ServiceLocator.getIt(),
      ),
      child: Navigator(
        observers: [RouteObserverService()],
        initialRoute: RoutersNames.loginScreen,
        onGenerateInitialRoutes: (_, initialRoute) {
          return [
            MaterialPageRoute(
              settings: RouteSettings(name: initialRoute),
              builder: (_) => const LoginScreen(),
            ),
          ];
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              switch (settings.name) {
                case RoutersNames.signUpScreen:
                  return const SignUpScreen();
                case RoutersNames.otpScreen:
                  return const OtpScreen();
                case RoutersNames.createNewPasswordScreen:
                  return const CreateNewPasswordScreen();
                default:
                  return const LoginScreen();
              }
            },
          );
        },
      ),
    );
  }
}