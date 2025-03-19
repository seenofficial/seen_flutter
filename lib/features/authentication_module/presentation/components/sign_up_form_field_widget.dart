import 'package:country_code_picker/country_code_picker.dart';
import 'package:enmaa/features/authentication_module/presentation/controller/remote_authentication_bloc/remote_authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/country_code_picker.dart';

class SignUpFormFieldWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  final String? Function(String?) validatePhone;
  final String? Function(String?) validateName;

  const SignUpFormFieldWidget({
    super.key,
    required this.phoneController,
    required this.nameController,
    required this.validatePhone,
    required this.validateName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NameField(
          controller: nameController,
          validator: validateName,
        ),
        SizedBox(height: context.scale(16)),
        _PhoneField(
          controller: phoneController,
          validator: validatePhone,
        ),
        SizedBox(height: context.scale(12)),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<RemoteAuthenticationCubit, RemoteAuthenticationState>(
              buildWhen: (previous, current) =>
              previous.currentCountryCode != current.currentCountryCode,
              builder: (context, state) {

                return Expanded(
                  child: AppTextField(
                    textDirection: TextDirection.ltr,
                    hintText: '0100000000000',
                    keyboardType: TextInputType.phone,
                    borderRadius: 20,
                    backgroundColor: ColorManager.greyShade,
                    padding: EdgeInsets.zero,
                    controller: controller,
                    validator: validator,
                    onChanged: (value) {
                      BlocProvider.of<RemoteAuthenticationCubit>(context)
                          .changeUserPhoneNumber(value);
                      if (!value.startsWith(state.currentCountryCode)) {
                        controller.clear();
                        controller.text = state.currentCountryCode;
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(width: context.scale(8)),

            Container(
                width: context.scale(88),
                height: context.scale(44),
                decoration: BoxDecoration(
                  color: ColorManager.greyShade,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomCountryCodePicker(
                  onChanged: (CountryCode countryCode) {
                    controller.clear();
                    controller.text = countryCode.dialCode!;
                    BlocProvider.of<RemoteAuthenticationCubit>(context)
                        .setCountryCode(countryCode.dialCode!);
                  },
                )
            ),
          ],
        ),
      ],
    );
  }
}

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const _NameField({
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الاسم الكامل',
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s12,
          ),
        ),
        SizedBox(height: context.scale(16)),
        AppTextField(
          hintText: 'قم بادخال اسمك',
          keyboardType: TextInputType.text,
          borderRadius: 20,
          backgroundColor: ColorManager.greyShade,
          padding: EdgeInsets.zero,
          controller: controller,
          validator: validator,
        )
      ],
    );
  }
}
