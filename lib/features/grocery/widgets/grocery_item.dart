import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';

class VegetableItem extends StatelessWidget {
  final String name;
  final String quantity;
  final void Function()? onTap;

  const VegetableItem({super.key, required this.name, required this.quantity, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  name,
                  style: getTextTheme().navigationText.copyWith(color: textBrownColor)
                ),
                Text(
                  'Quantity: $quantity',
                  style: getTextTheme().defaultText.copyWith(color: textBrownColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}