import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final double borderRadius;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxLines;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    this.width = double.infinity,
    this.height = 44,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.textStyle,
    this.backgroundColor = Colors.white,
    this.borderRadius = 20,
    this.onChanged,
    this.onTap,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            onTap: onTap,
            maxLines: maxLines ?? 1,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textStyle ??
                  TextStyle(
                    color: const Color(0xFF707070),
                    fontSize: 12,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
