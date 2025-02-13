
import 'package:enmaa/features/authentication_module/presentation/controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final String? Function(String?) validatePhone;
  final String? Function(String?) validatePassword;

  const LoginFormFields({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.validatePhone,
    required this.validatePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PhoneField(
          controller: phoneController,
          validator: validatePhone,
        ),
        SizedBox(height: context.scale(16)),
        _PasswordField(
          controller: passwordController,
          validator: validatePassword,
        ),
        SizedBox(height: context.scale(12)),
        _ForgotPasswordText(),
      ],
    );
  }
}

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const _PhoneField({
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'رقم الموبايل',
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s12,
          ),
        ),
        SizedBox(height: context.scale(16)),
        AppTextField(
          hintText: '0100000000000',
          keyboardType: TextInputType.phone,
          borderRadius: 20,
          backgroundColor: ColorManager.greyShade,
          padding: EdgeInsets.zero,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const _PasswordField({
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'كلمة المرور',
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s12,
          ),
        ),
        SizedBox(height: context.scale(16)),
        BlocBuilder<RemoteAuthenticationCubit, RemoteAuthenticationState>(
          buildWhen: (previous, current) => previous.loginPasswordVisibility != current.loginPasswordVisibility,
          builder: (context, state) {
            final bool showPassword = state.loginPasswordVisibility;
            return AppTextField(
              hintText: 'كلمة المرور',
              keyboardType: TextInputType.text,
              borderRadius: 20,
              backgroundColor: ColorManager.greyShade,
              padding: EdgeInsets.zero,
              controller: controller,
              obscureText: !showPassword,
              validator: validator,
              suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: ColorManager.grey,
                ),
                onPressed: (){
                  context.read<RemoteAuthenticationCubit>().changeLoginPasswordVisibility();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ForgotPasswordText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Text(
        'نسيت كلمة المرور؟',
        style: getUnderlineBoldStyle(
          color: ColorManager.redColor,
          fontSize: FontSize.s12,
        ),
      ),
    );
  }
}