import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/components/button_app_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/routers/route_names.dart';
import '../../domain/entities/login_request_entity.dart';
import '../controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import 'guest_button_component.dart';

class LoginButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginRequestEntity loginRequestBody;

  const LoginButtons({
    super.key,
    required this.formKey,
    required this.loginRequestBody,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LoginButton(formKey: formKey, loginRequestBody: loginRequestBody),
        SizedBox(height: context.scale(16)),
        GuestButtonComponent(),
        SizedBox(height: context.scale(24)),
        _SignUpSection(),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginRequestEntity loginRequestBody;

  const _LoginButton({
    required this.formKey,
    required this.loginRequestBody,
  });

  void _login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<RemoteAuthenticationCubit>().remoteLogin(loginRequestBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonAppComponent(
      width: double.infinity,
      padding: EdgeInsets.zero,
      buttonContent: Center(
        child: Text(
          'تسجيل الدخول',
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
      onTap: () => _login(context),
    );
  }
}


class _SignUpSection extends StatelessWidget {
  const _SignUpSection();

  void _onSignUp(BuildContext context) {
    Navigator.pushNamed(context, RoutersNames.signUpScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ليس لديك حساب؟',
          style: getMediumStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s14,
          ),
        ),
        SizedBox(width: context.scale(2)),
        InkWell(
          onTap: () => _onSignUp(context),
          child: Text(
            'أنشئ واحدًا الآن',
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
