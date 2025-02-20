import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/horizontal_gap.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';

class NotificationItem extends StatelessWidget {
  final String itemName;
  final String expiryMessage;
  final String? notifyDay;

  const NotificationItem({
    required this.itemName,
    required this.expiryMessage,
    Key? key,
    this.notifyDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (notifyDay != null && notifyDay?.isNotEmpty == true)
          CustomText(notifyDay!,
              style: getTextTheme().navigationText.copyWith(
                    color: textBrownColor,
                  )),
        VerticalGap(scaleH(4)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: lightPinkColor,
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Row(
            children: [
              Image.asset(
                notificationBadgeIcon,
                width: scaleW(40),
                height: scaleW(40),
              ),
              HorizontalGap(scaleW(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("$itemName $expiryMessage",
                        style: getTextTheme()
                            .navigationText
                            .copyWith(color: primaryColor, fontSize: scaleW(14))),
                  ],
                ),
              ),
            ],
          ),
        ),
        VerticalGap(scaleH(10))
      ],
    );
  }
}
