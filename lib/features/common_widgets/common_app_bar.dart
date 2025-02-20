import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

AppBar buildAppBar(String appBarText, {bool showBackIcon = true,List<Widget>? actions}) {
  return AppBar(
    leading: showBackIcon ? IconButton(
      icon: Image.asset(arrowIcon, width: scaleW(20), height: scaleW(20),), // Red back arrow
      onPressed: () {
        Get.back();
      },
    ) : null,
    title: CustomText(
      appBarText,
      style: getTextTheme().navigationText.copyWith(color: primaryColor, fontSize: scaleW(18))
    ),
    centerTitle: true,
    backgroundColor: Colors.white, 
    elevation: 0,
    actions: actions,
  );
}