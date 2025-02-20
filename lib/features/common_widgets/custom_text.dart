// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/utils/extensions.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {super.key,
      this.style,
      this.textAlign,
      this.maxLines,
      this.overFlow,
      this.testKey});

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overFlow;
  final String? testKey;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: testKey.hasData() ? Key(testKey!) : null,
      style: style?.copyWith(fontFamily: fontFamilyPoppins,),
      overflow: overFlow,
      textAlign: textAlign,
      maxLines: maxLines,
      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
    );
  }
}

class TitleAppBarTextStyle {
  static TextStyle getAppBarTitleTextStyle_16() {
    return TextStyle(
        fontSize: scaleW(22), color: Colors.black, fontWeight: FontWeight.w700,
        fontFamily:fontFamilyPoppins
    );
  }
}
