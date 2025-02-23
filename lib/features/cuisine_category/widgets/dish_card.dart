import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/horizontal_gap.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_model.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';

class DishCard extends StatelessWidget {
  final RecipeModel recipeModel;
  final Function() onFavClick;
  final bool isMissing;

  const DishCard(
      {super.key,
      required this.recipeModel,
      required this.onFavClick,
      this.isMissing = true});

  @override
  Widget build(BuildContext context) {
    String valueText = '';
    if (!isMissing) {
      int mealType = int.parse(recipeModel.mealTypeChoice ?? '3');
      valueText = mealType == 1
          ? "Easy"
          : mealType == 2
              ? "Medium"
              : mealType == 3
                  ? "Hard"
                  : "";
    } else {
      int missingItems = recipeModel.missingItems ?? 0;
      valueText =
          missingItems == 0 ? "All items avb" : "$missingItems item missing";
    }
    return InkWell(
      onTap: () {
        AppRouting()
            .routeTo(NameRoutes.cuisineRecipeScreen, arguments: recipeModel.id);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: scaleH(100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: pinkTextColor)),
            margin: EdgeInsets.symmetric(horizontal: scaleW(10)),
            padding: EdgeInsets.symmetric(
                vertical: scaleH(14), horizontal: scaleW(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  recipeModel.name ?? '',
                  style: getTextTheme().defaultText.copyWith(
                      color: textBrownColor,
                      fontSize: scaleW(14),
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                ),
                CustomText(recipeModel.subtitle ?? '',
                    style: getTextTheme().defaultText.copyWith(
                          color: textBrownColor,
                          fontSize: scaleW(10),
                        ),
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis),
                VerticalGap(scaleH(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(valueText,
                          style: getTextTheme().defaultText.copyWith(
                                color: pinkTextColor,
                                fontSize: scaleW(10),
                              ),
                              maxLines: 1,),
                      
                    ),
                    Image.asset(
                      clockIcon,
                      width: scaleW(10),
                      height: scaleW(10),
                    ),
                    HorizontalGap(scaleW(4)),
                    CustomText(recipeModel.recipeTime ?? '',
                        style: getTextTheme().defaultText.copyWith(
                              color: pinkTextColor,
                              fontSize: scaleW(10),
                            )),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: scaleW(160),
              height: scaleH(140),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.network(
                    recipeModel.imageUrl ?? '',
                    fit: BoxFit.cover,
                    height: scaleH(140),
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                          height: scaleH(140),
                          width: double.infinity,
                          child: const Icon(Icons.error));
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: scaleH(10),
              right: scaleW(10),
              child: InkWell(
                onTap: () {
                  onFavClick();
                },
                child: SizedBox(
                    width: scaleW(24),
                    height: scaleW(24),
                    child: recipeModel.isFav ?? false
                        ? Image.asset(favoriteActiveIcon)
                        : Image.asset(favoriteInActiveIcon)),
              ))
        ],
      ),
    );
  }
}
