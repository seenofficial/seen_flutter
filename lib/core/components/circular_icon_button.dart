import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:flutter/material.dart';
import '../../features/home_module/home_imports.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.iconPath,
    this.containerSize = 24,
    this.iconSize = 16,
    this.backgroundColor = Colors.white,
    this.onPressed,
    this.padding,
  });

  final String iconPath;
  final double containerSize;
  final double iconSize;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(containerSize / 2),
      child: Container(
        width: containerSize,
        height: containerSize,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: SvgImageComponent(
          iconPath: iconPath,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}
