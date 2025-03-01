import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_model.dart';
import 'package:fridge_app/features/favorites/favorites_repository.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<RecipeModel> favList = RxList([]);

  @override
  onReady(){
    super.onReady();
    getFavoriteList();
  }

  getFavoriteList() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      int userId =
          (await SharedPreference.getInt(SharedPreference.userId)) ?? 0;
      favList.value = await FavoritesRepository().getFavoriteList(userId);
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  Future<bool> addToFavorite(int productId) async {
    int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      bool isSuccess =
          await FavoritesRepository().addToFavorites(userId, productId);
      Get.back();
      return isSuccess;
    } catch (e) {
      Get.back();
    }
    return false;
  }

  Future<bool> removeToFavorite(int productId) async {
    int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      bool isSuccess =
          await FavoritesRepository().removeToFavorites(userId, productId);
      Get.back();
      return isSuccess;
    } catch (e) {
      Get.back();
    }
    return false;
  }

  void onFavClick(int index) async {
    bool currentValue = favList[index].isFav ?? false;
    if (currentValue) {
      bool isSuccess = await removeToFavorite(favList[index].id ?? 0);
      if (isSuccess) {
        favList.removeAt(index);
        Get.snackbar('Success', 'Recipe removed from favroites.',);
        favList.refresh();
      }
    } else {
      bool isSuccess = await addToFavorite(favList[index].id ?? 0);
      if (isSuccess) {
        favList[index].isFav = !currentValue;
        favList.refresh();
      }
    }
  }
}
