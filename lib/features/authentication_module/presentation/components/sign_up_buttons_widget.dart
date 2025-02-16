import 'package:enmaa/configuration/routers/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/components/button_app_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/custom_snack_bar.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/sign_up_request_entity.dart';
import '../controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import 'guest_button_component.dart';

class SignUpButtonsWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function() signUpOnTap;

  const SignUpButtonsWidget({
    super.key,
    required this.formKey,
    required this.signUpOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// sign up button sends otp to the number
        _SignUpButton(formKey: formKey, signUpOnTap:signUpOnTap),
        SizedBox(height: context.scale(16)),
        GuestButtonComponent(),
        SizedBox(height: context.scale(24)),
        _LoginSection(),
      ],
    );
  }
}

/// sends otp
class _SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function() signUpOnTap ;
  const _SignUpButton({
    required this.formKey,
    required this.signUpOnTap,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteAuthenticationCubit, RemoteAuthenticationState>(
      buildWhen: (previous, current) {
        return previous.sendOtpRequestState != current.sendOtpRequestState;
      },
      builder: (context, state) {
        return ButtonAppComponent(
          width: double.infinity,
          padding: EdgeInsets.zero,
          buttonContent: Center(
            child: Text(
              'التالي',
              style: getBoldStyle(
                color: ColorManager.whiteColor,
                fontSize: FontSize.s14,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(context.scale(20)),
          ),
          onTap: (){
            signUpOnTap();
          },
        );
      },
    );
  }
}

class _LoginSection extends StatelessWidget {
  const _LoginSection();

  void _onLogIn(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لديك حساب بالفعل؟',
          style: getMediumStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s14,
          ),
        ),
        SizedBox(width: context.scale(2)),
        InkWell(
          onTap: () => _onLogIn(context),
          child: Text(
            'تسجيل الدخول',
            style: getUnderlineBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSize.s14,
            ),
          ),
        ),
      ],
    );
  }
}
