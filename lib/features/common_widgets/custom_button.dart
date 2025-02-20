import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/themes/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.icon, this.padding, required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
      icon: icon != null ? Image.asset(icon!) : const SizedBox.shrink(),
      label: Text(
        text,
        style: getTextTheme().navigationText.copyWith(color: textColor, fontSize: scaleW(16)),
      ),
    );
  }
}