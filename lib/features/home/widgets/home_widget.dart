import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/home/data/home_controller.dart';
import 'package:fridge_app/features/home/widgets/category_grid.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/features/home/widgets/searchable_list.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class HomeWidget extends GetView<HomeController> {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchableDropdown(
            onSearch: (query) async {
              return [];
            },
          ),
          VerticalGap(scaleH(10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
            child: CustomText(
              "User's Fridge",
              style: getTextTheme().navigationText.copyWith(
                    color: textBrownColor,
                  ),
              textAlign: TextAlign.start,
            ),
          ),
          Obx(() => controller.categories.isEmpty ? 
            Expanded(child: EmptyFridgeMessage(emptyString: 'empty_fridge'.tr,))
           : 
           Column(
            children: [
          VerticalGap(scaleH(10)),
          CategoryGrid(categories: controller.categories),
          VerticalGap(scaleH(40)),
          Center(
            child: CustomButton(
              text: 'lets_cook'.tr,
              onPressed: () {
                AppRouting().routeTo(NameRoutes.cuisineCategoryScreen);
              },
              backgroundColor: primaryColor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: scaleH(16), horizontal: scaleW(40)),
              borderRadius: 20,
            ),
          ),
            ],
           )
          )
        ],
      );
  }
}