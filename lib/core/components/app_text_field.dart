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
  final TextDirection? textDirection;

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
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: textDirection ?? (isArabic ? TextDirection.rtl : TextDirection.ltr),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onChanged: onChanged,
              onTap: onTap,
              maxLines: maxLines ?? 1,
              textAlign: (textDirection == TextDirection.rtl || (textDirection == null && isArabic))
                  ? TextAlign.right
                  : TextAlign.left,
              validator: validator,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textStyle ??
                    const TextStyle(
                      color: Color(0xFF707070),
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
          ),
        ],
      ),
    );
  }
}
