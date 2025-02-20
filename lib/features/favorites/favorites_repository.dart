import 'package:dio/dio.dart';
import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_model.dart';

class FavoritesRepository {
  Future<List<RecipeModel>> getFavoriteList(int userId) async {
    try {
      dynamic response = await ApiBaseHelper().getHTTP(
          ApiEndPointUrls.productWishListUrl,
          queryParameters: {"user_id": userId});
      print("getCuisineRecipeDetailList data $response");
      return (response['data'] as List).map((e) => RecipeModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addToFavorites(int userId, int productId) async {
    try {
      Response response = await ApiBaseHelper().postHTTP(
          ApiEndPointUrls.addProductWishListUrl,
          {"user_id": userId, "product_id": productId});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeToFavorites(int userId, int productId) async {
    try {
      Response response = await ApiBaseHelper().postHTTP(
          ApiEndPointUrls.removeProductWishListUrl,
          {"user_id": userId, "product_id": productId});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
