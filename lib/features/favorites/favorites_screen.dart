import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/cuisine_category/widgets/dish_card.dart';
import 'package:fridge_app/features/favorites/data/favorites_controller.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildAppBar('Favorites'.tr, showBackIcon: false),
          Expanded(child:
          Obx(
            () => favoriteController.favList.isEmpty
                ? const Expanded(
                    child: EmptyFridgeMessage(
                        emptyString: 'No Favorite Recipe Available for now.'))
                : GridView.builder(
                  shrinkWrap: true,
                    padding: EdgeInsets.all(scaleW(10)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: scaleW(10),
                      mainAxisSpacing: scaleH(20),
                      childAspectRatio: 0.7,
                    ),
                    itemCount: favoriteController.favList.length,
                    itemBuilder: (context, index) {
                      final dish = favoriteController.favList[index];
                      return DishCard(
                        recipeModel: dish,
                        isMissing: false,
                        onFavClick: () {
                          // favoriteController.onFavClick(index);
                        },
                      );
                    },
                  ),
          ),
          )
        ],
      ),
    );
  }
}
