import 'package:dio/dio.dart';
import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/features/home/data/data/category_data.dart';
import 'package:fridge_app/features/home/data/data/drop_down_data.dart';
import 'package:fridge_app/features/home/data/data/entry_data.dart';
import 'package:fridge_app/features/home/data/data/inventory_model.dart';
import 'package:fridge_app/features/home/data/data/product_item_request.dart';

class HomeRepository {
  Future<List<Inventory>?> homeInventoryList(int userId) async {
    try {
      Response response = await ApiBaseHelper().postHTTP(
          ApiEndPointUrls.homeUrl, {"user_id": userId},
          queryParameters: {"id": userId});
      if (response.statusCode == 200) {
        List<Inventory> inventory = (response.data['inventory'] as List)
            .map((e) => Inventory.fromJson(e))
            .toList();
        print("inventory List ${inventory.length}");
        return inventory;
      } else {
        return [];
      }
    } catch (e) {
      print("inventory error $e");
      return [];
    }
  }

  Future<List<CategoryData>> productList(String searchWord) async {
    try {
      dynamic response = await ApiBaseHelper().getHTTP(
          ApiEndPointUrls.searchUrl,
          queryParameters: {"search": searchWord});
        List<CategoryData> data =
            (response as List).map((e) => CategoryData.fromJson(e)).toList();
        
        return data;
    } catch (e) {
      print("error $e");
      return [];
    }
  }

  Future<bool> addProductData(ProductItemRequest request) async {
    try {
      Response response = await ApiBaseHelper()
          .postHTTP(ApiEndPointUrls.addProductUrl, request.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateEntryQuantity(List<EntryData> entryList) async {
    try {
      Response response = await ApiBaseHelper().postHTTP(
          ApiEndPointUrls.updateQuantityUrl, {"entries" : entryList.map((e) => e.toJson()).toList()});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

    Future getDropDownData() async {
    try {
      dynamic response = await ApiBaseHelper().getHTTP(
          ApiEndPointUrls.dropdownDataUrl);
          print("dropdownData ${response['category']} ${response['quantity']}");
    return response;
    } catch (e) {
      return false;
    }
  }
}
