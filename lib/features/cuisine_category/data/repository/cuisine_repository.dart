import 'package:dio/dio.dart';
import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/features/cuisine_category/data/data/cuisine_model.dart';
import 'package:fridge_app/features/cuisine_category/data/data/ingredient_model.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_detail_model.dart';
import 'package:fridge_app/features/cuisine_category/data/data/recipe_model.dart';

class CuisineRepository {
  Future<List<CuisineModel>> getCuisineList(int userId) async {
    try {
      dynamic response = await ApiBaseHelper().getHTTP(
          ApiEndPointUrls.cuisineListUrl,
          queryParameters: {"user_id": userId});
      print("getCuisineList data $response");
      return (response['data'] as List)
          .map((e) => CuisineModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<RecipeModel>> getCuisineRecipeList(
      int userId, int type, int cuisineId) async {
    try {
      dynamic response = await ApiBaseHelper()
          .getHTTP(ApiEndPointUrls.cuisineRecipeListUrl, queryParameters: {
        "user_id": userId,
        "type": type,
        "cuisine": cuisineId
      });
      print("getCuisineRecipeList data $response");
      return (response['data'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<RecipeDetailModel?> getCuisineRecipeDetailList(
      int userId, int id) async {
    try {
      dynamic response = await ApiBaseHelper().getHTTP(
          ApiEndPointUrls.cuisineRecipeDetailUrl,
          queryParameters: {"user_id": userId, "id": id});
      print("getCuisineRecipeDetailList data $response");
      return RecipeDetailModel.fromJson(response['data']);
    } catch (e) {
      return null;
    }
  }

  Future<List<IngredientModel>?> getIngredientList(int userId, int id) async {
    try {
      dynamic response = await ApiBaseHelper().getHTTP(
          ApiEndPointUrls.getIngredientsUrl,
          queryParameters: {"user_id": userId, "id": id});
      print("getIngredientList data $response");
      return (response['data'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateIngredientData(int userId, List<IngredientModel> list) async {
    try {
      Response response = await ApiBaseHelper().postHTTP(
          ApiEndPointUrls.letsCookUrl, {
            "user_id": userId,
            "products" : list.map((e) => {"id" : e.id, "qt" : e.quantity, "unit" : e.unit}).toList()
          },);

      if(response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
