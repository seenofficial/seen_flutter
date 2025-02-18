import 'package:flutter/material.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import '../../features/add_new_real_estate/presentation/components/form_widget_component.dart';

class GenericFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final String iconPath;
  final TextEditingController controller;

  const GenericFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    required this.iconPath,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormWidgetComponent(
      label: label,
      content: AppTextField(
        height: 40,
        hintText: hintText,
        keyboardType: keyboardType,
        backgroundColor: Colors.white,
        borderRadius: 20,
        padding: EdgeInsets.zero,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 12, top: 12, bottom: 12),
          child: SvgImageComponent(iconPath: iconPath),
        ),
        controller: controller,
        onChanged: (value) {

        },
      ),
    );
  }
}