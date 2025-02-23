import 'package:dio/dio.dart';
import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/features/sign_up/data/model/user_model.dart';
import 'package:fridge_app/storage/shared_preference.dart';

class SignUpRepository{
  Future<bool> signup(UserModel userModel) async {
    try {
     Response response = await ApiBaseHelper().postHTTP(ApiEndPointUrls.registerUserUrl, 
     userModel.toJson());
    if(response.statusCode == 200){
      await SharedPreference.setString(SharedPreference.userAccessToken, response.data['token']);
     await SharedPreference.setInt(SharedPreference.userId, response.data['user_id']);
      return true;
    } else{
      return false;
    }
    } catch (e) {
      return false;
    }
    
  }

  Future<bool> updateUser(UserModel userModel) async {
    try {
     Response response = await ApiBaseHelper().postHTTP(ApiEndPointUrls.updateUrl, 
     userModel.toJson());
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