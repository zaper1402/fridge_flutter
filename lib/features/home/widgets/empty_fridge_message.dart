import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/utils.dart';

class EmptyFridgeMessage extends StatelessWidget {
  final String emptyString;
  const EmptyFridgeMessage({super.key, required this.emptyString});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        emptyString,
        style: getTextTheme()
            .navigationText
            .copyWith(color: greyColor, fontSize: scaleW(20)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
