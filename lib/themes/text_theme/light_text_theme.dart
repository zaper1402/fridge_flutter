import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:fridge_app/themes/text_theme/base_text_theme.dart';

class LightTextTheme extends BaseTextTheme {
  @override
  TextStyle get appTextStyle => TextStyle(
        fontSize: scaleW(20),
        fontWeight: FontWeight.w600,
        fontFamily: fontFamilyPoppins,
        color: primaryColor,
      );

  @override
  TextStyle get textHeadline => appTextStyle;

  @override
  TextStyle get navigationText =>
      appTextStyle.copyWith(fontSize: scaleW(16), fontWeight: FontWeight.w600);

  @override
  TextStyle get defaultText =>
      appTextStyle.copyWith(fontSize:scaleW(14), fontWeight: FontWeight.w400);

  @override
  TextStyle get smallText =>
      appTextStyle.copyWith(fontSize: scaleW(12), fontWeight: FontWeight.w400);

  @override
  TextStyle get t10Style => appTextStyle.copyWith(fontSize: scaleW(10));

  @override
  TextStyle get t18Style => appTextStyle.copyWith(fontSize:  scaleW(18));

  @override
  TextStyle get t26Style => appTextStyle.copyWith(fontSize:  scaleW(26));

  @override
  TextStyle get t40Style => appTextStyle.copyWith(fontSize: scaleW(40));

  @override
  TextStyle get t48Style => appTextStyle.copyWith(fontSize: scaleW(48));

  @override
  TextStyle get t32Style => appTextStyle.copyWith(fontSize: scaleW(32));

  @override
  TextStyle get t22Style => appTextStyle.copyWith(fontSize: scaleW(22));

  @override
  TextStyle get t24Style => appTextStyle.copyWith(fontSize: scaleW(24));

  @override
  TextStyle get t28Style => appTextStyle.copyWith(fontSize: scaleW(28));

  @override
  TextStyle get t36Style => appTextStyle.copyWith(fontSize: scaleW(36));

  @override
  TextStyle get t60Style => appTextStyle.copyWith(fontSize: scaleW(60));

  @override
  TextStyle get t64Style => appTextStyle.copyWith(fontSize: scaleW(64));

  @override
  TextStyle get t56Style => appTextStyle.copyWith(fontSize: scaleW(56));

  @override
  TextStyle get t100Style => appTextStyle.copyWith(fontSize: scaleW(100));
}
