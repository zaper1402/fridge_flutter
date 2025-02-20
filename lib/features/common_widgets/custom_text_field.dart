import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final RxString errorText;
  final TextEditingController controller;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false, 
    required this.errorText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          widget.label,
          style: getTextTheme().defaultText.copyWith(color: textBrownColor),
        ),
        SizedBox(height: scaleW(10)),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          cursorColor: lightBrownColor.withOpacity(0.4),
          style: getTextTheme().defaultText.copyWith(color: lightBrownColor),
          scrollPadding: EdgeInsets.zero,
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: scaleW(20)),
            fillColor: Colors.pink[100],
            hintText: widget.hintText,
            hintStyle: getTextTheme().defaultText.copyWith(color: lightBrownColor.withOpacity(0.4),),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                  color: lightBrownColor.withOpacity(0.4),
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
        Obx(
          () => CustomText(
            widget.errorText.value,
            style: getTextTheme().defaultText.copyWith(color: Colors.red,fontSize: scaleW(10)),
          ),
        ),
      ],
    );
  }
}