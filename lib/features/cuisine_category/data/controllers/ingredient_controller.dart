import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/cuisine_category/data/data/ingredient_model.dart';
import 'package:fridge_app/features/cuisine_category/data/repository/cuisine_repository.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get/get.dart';

class IngredientController extends GetxController{
  RxList<IngredientModel> ingredientList = RxList([
  ]);
  List<IngredientModel> updatedList = [];
  int recipeId = 0;
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
      List<IngredientModel> data =
          (await CuisineRepository().getIngredientList(userId, recipeId)) ?? [];
      ingredientList.addAll(data);
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  Future<bool> updateIngredientData() async {
    int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      bool isSuccess =
          await CuisineRepository().updateIngredientData(userId, updatedList);
      Get.back();
      return isSuccess;
    } catch (e) {
      Get.back();
    }
    return false;
  }
}