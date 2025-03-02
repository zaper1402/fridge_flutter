import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/home/data/home_controller.dart';
import 'package:fridge_app/features/home/widgets/category_grid.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeController controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SearchableDropdown(
        //   onSearch: (query) async {
        //     return [];
        //   },
        // ),
        VerticalGap(scaleH(30)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
          child: Obx(
            () => CustomText(
              "${controller.userName}'s Fridge",
              style: getTextTheme().navigationText.copyWith(
                    color: textBrownColor,
                  ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Obx(() => controller.categories.isEmpty
            ? Expanded(
                child: EmptyFridgeMessage(
                emptyString: 'empty_fridge'.tr,
              ))
            : Expanded(
                child: Column(
                  children: [
                    VerticalGap(scaleH(10)),
                    controller.categories.length >= 9
                        ? Expanded(
                            child:
                                CategoryGrid(categories: controller.categories))
                        : CategoryGrid(categories: controller.categories),
                    VerticalGap(scaleH(30)),
                    Center(
                      child: CustomButton(
                        text: 'lets_cook'.tr,
                        onPressed: () {
                          AppRouting()
                              .routeTo(NameRoutes.cuisineCategoryScreen);
                        },
                        backgroundColor: primaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: scaleH(16), horizontal: scaleW(40)),
                        borderRadius: 20,
                      ),
                    ),
                    VerticalGap(scaleH(20)),
                  ],
                ),
              ))
      ],
    );
  }
}
