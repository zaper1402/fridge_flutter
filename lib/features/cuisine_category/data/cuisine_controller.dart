import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/cuisine_category/data/data/cuisine_model.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_detail_model.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_model.dart';
import 'package:fridge_app/features/cuisine_category/data/repository/cuisine_repository.dart';
import 'package:fridge_app/features/favorites/favorites_repository.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get/get.dart';

class CuisineController extends GetxController {
  RxList<CuisineModel> cuisineModelList = RxList([]);
  RxList<RecipeModel> cuisineRecipeModelList = RxList([]);
  Rxn<RecipeDetailModel> recipeDetailModel = Rxn();

  final List<CuisineModel> categories = [
    CuisineModel(name: 'Seafood', imageUrl: seafoodImage),
    CuisineModel(name: 'Italian', imageUrl: italianImage),
    CuisineModel(name: 'Mexican', imageUrl: mexicanImage),
    CuisineModel(name: 'Mediterranean', imageUrl: mediterraneanImage),
    CuisineModel(name: 'Indian', imageUrl: indianImage),
    CuisineModel(name: 'French', imageUrl: frenchImage),
    CuisineModel(name: 'Chinese', imageUrl: chineseImage),
  ];

  @override
  void onReady() {
    super.onReady();
    getCuisineList();
  }

  Future getCuisineList() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
      List<CuisineModel> data =
          await CuisineRepository().getCuisineList(userId);
      for (var cuisine in data) {
        List<CuisineModel> model = categories
            .where((element) => element.name == cuisine.name)
            .toList();
        if (model.isNotEmpty) {
          cuisine.imageUrl = model.first.imageUrl;
        }
      }
      cuisineModelList.clear();
      cuisineModelList.addAll(data);
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  Future getCuisineRecipeList(int type, int cuisineId) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
      cuisineRecipeModelList.value = await CuisineRepository()
          .getCuisineRecipeList(userId, type, cuisineId);
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  Future getCuisineRecipeDetailList(int cuisineId) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
      recipeDetailModel.value = await CuisineRepository()
          .getCuisineRecipeDetailList(userId, cuisineId);
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
    bool currentValue = cuisineRecipeModelList[index].isFav ?? false;
    if (currentValue) {
      bool isSuccess =
          await removeToFavorite(cuisineRecipeModelList[index].id ?? 0);
      if (isSuccess) {
        cuisineRecipeModelList[index].isFav = !currentValue;
        cuisineRecipeModelList.refresh();
      }
    } else {
      bool isSuccess =
          await addToFavorite(cuisineRecipeModelList[index].id ?? 0);
      if (isSuccess) {
        cuisineRecipeModelList[index].isFav = !currentValue;
        cuisineRecipeModelList.refresh();
      }
    }
  }

  onRecipeDetailFavClick(int productId) async {
    if (recipeDetailModel.value?.isFav ?? false) {
      bool isSuccess = await removeToFavorite(productId);
      if (isSuccess) {
        recipeDetailModel.value!.isFav =
            !((recipeDetailModel.value?.isFav) ?? false);
      }
    } else {
      bool isSuccess = await addToFavorite(productId);
      if (isSuccess) {
        recipeDetailModel.value!.isFav =
            !((recipeDetailModel.value?.isFav) ?? false);
      }
    }
    recipeDetailModel.refresh();
  }
}
