import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class AlreadyAccountWidget extends StatelessWidget {
  final Function()? onTap;
  const AlreadyAccountWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: 'already_have_account'.tr,
              style: getTextTheme()
                  .appTextStyle
                  .copyWith(color: textBrownColor, fontSize: scaleW(10),
                  fontWeight: FontWeight.w300)),
          TextSpan(
            text: 'log_in'.tr,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: getTextTheme().appTextStyle.copyWith(fontSize: scaleW(10)),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
