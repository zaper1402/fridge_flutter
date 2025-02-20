import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/horizontal_gap.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/cuisine_category/data/cuisine_controller.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class CuisineRecipeScreen extends StatefulWidget {
  const CuisineRecipeScreen({super.key});

  @override
  State<CuisineRecipeScreen> createState() => _CuisineRecipeScreenState();
}

class _CuisineRecipeScreenState extends State<CuisineRecipeScreen> {
  CuisineController cuisineController = Get.isRegistered<CuisineController>() ? Get.find<CuisineController>()
  : Get.put(CuisineController());
  int? cuisineId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.arguments != null && Get.arguments is int) {
        cuisineId = Get.arguments;
      }
      if (cuisineId != null) {
        cuisineController.getCuisineRecipeDetailList(cuisineId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('cuisine_recipe'.tr, actions: [
        InkWell(
          onTap: () {
            cuisineController.onRecipeDetailFavClick(
                cuisineController.recipeDetailModel.value?.id ?? 0);
          },
          child: Obx(
            () => Padding(
              padding: EdgeInsets.all(scaleW(10)),
              child: Image.asset(
                (cuisineController.recipeDetailModel.value?.isFav ?? false)
                    ? favoriteActiveIcon
                    : favoriteInActiveIcon,
                width: scaleW(24),
                height: scaleW(24),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(scaleW(5)),
            child: Image.asset(
              homeIcon,
              width: scaleW(24),
              height: scaleW(24),
              color: primaryColor,
            ),
          ),
        )
      ]),
      body: Obx(
        () => cuisineController.recipeDetailModel.value == null
            ? const Center(
                child: EmptyFridgeMessage(emptyString: 'Recipe not found'),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalGap(scaleH(10)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: scaleW(40)),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      height: scaleH(300),
                      width: double.infinity,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            child: Image.network(
                              cuisineController
                                      .recipeDetailModel.value?.imageUrl ??
                                  '',
                              height: scaleH(250),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return SizedBox(
                                  height: scaleH(250),
                                  child: const Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                          VerticalGap(scaleH(10)),
                          CustomText(
                            cuisineController.recipeDetailModel.value?.name ??
                                '',
                            style: getTextTheme().defaultText.copyWith(
                                fontSize: scaleW(20), color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    VerticalGap(scaleH(20)),
                    Container(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: "Let's Go",
                        onPressed: () {
                          AppRouting().routeTo(NameRoutes.fridgeIngredientScreen, arguments: cuisineId);
                        },
                        backgroundColor: primaryColor,
                        textColor: Colors.white,
                        borderRadius: 12,
                        padding: EdgeInsets.symmetric(
                            horizontal: scaleW(40), vertical: scaleH(10)),
                      ),
                    ),
                    VerticalGap(scaleH(10)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                'Details',
                                style: getTextTheme().defaultText.copyWith(
                                      fontSize: scaleW(16),
                                    ),
                              ),
                              HorizontalGap(
                                scaleW(10),
                              ),
                              Image.asset(
                                clockIcon,
                                width: scaleW(10),
                                height: scaleW(10),
                                color: textBrownColor,
                              ),
                              HorizontalGap(scaleW(4)),
                              SizedBox(
                                height: scaleH(12),
                                child: CustomText(
                                  cuisineController.recipeDetailModel.value
                                          ?.recipeTime ??
                                      '',
                                  style: getTextTheme().defaultText.copyWith(
                                        color: textBrownColor,
                                        fontSize: scaleW(10),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          VerticalGap(scaleH(10)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              cuisineController
                                      .recipeDetailModel.value?.details ??
                                  '',
                              style: getTextTheme().defaultText.copyWith(
                                  fontSize: scaleW(12), color: textBrownColor),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          VerticalGap(scaleH(14)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              'Ingredients',
                              style: getTextTheme().defaultText.copyWith(
                                    fontSize: scaleW(16),
                                  ),
                            ),
                          ),
                          VerticalGap(scaleH(10)),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cuisineController.recipeDetailModel
                                          .value?.ingredients?.length ??
                                      0,
                                  itemBuilder: (_, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: scaleW(4),
                                          height: scaleW(4),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              shape: BoxShape.circle),
                                        ),
                                        HorizontalGap(scaleW(8)),
                                        CustomText(
                                          cuisineController
                                                  .recipeDetailModel
                                                  .value
                                                  ?.ingredients?[index]
                                                  .quantity ??
                                              '',
                                          style: getTextTheme()
                                              .defaultText
                                              .copyWith(
                                                fontSize: scaleW(12),
                                              ),
                                        ),
                                        HorizontalGap(scaleW(8)),
                                        Expanded(
                                          child: CustomText(
                                            cuisineController
                                                    .recipeDetailModel
                                                    .value
                                                    ?.ingredients?[index]
                                                    .name ??
                                                '',
                                            style: getTextTheme()
                                                .defaultText
                                                .copyWith(
                                                    fontSize: scaleW(12),
                                                    color: textBrownColor),
                                          ),
                                        )
                                      ],
                                    );
                                  }))
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
