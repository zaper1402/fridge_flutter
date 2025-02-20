import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: 'by_continuing_to'.tr,
              style: getTextTheme()
                  .appTextStyle
                  .copyWith(color: textBrownColor, fontSize: scaleW(10),
                  fontWeight: FontWeight.w300)),
          TextSpan(
            text: 'terms_of_use'.tr,
            style: getTextTheme().appTextStyle.copyWith(
                color: textBrownColor,
                fontWeight: FontWeight.bold,
                fontSize: scaleW(10)),
          ),
          TextSpan(
            text: ' and ',
            style: getTextTheme()
                .appTextStyle
                .copyWith(color: textBrownColor, fontSize: scaleW(10),
                fontWeight: FontWeight.w300),
          ),
          TextSpan(
            text: 'privacy_policy'.tr,
            style: getTextTheme().appTextStyle.copyWith(
                color: textBrownColor,
                fontWeight: FontWeight.bold,
                fontSize: scaleW(10)),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
