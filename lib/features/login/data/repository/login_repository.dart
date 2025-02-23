import 'package:dio/dio.dart';
import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/storage/shared_preference.dart';

class LoginRepository{
  Future<bool> login(String email, String password, {bool isGoogleSignin = false}) async {
    try {
      var data = isGoogleSignin ? {
        "email" : email,
        "is_google_login" : true
      } : {
      "email" : email,
      "password" : password,
    };
     Response response = await ApiBaseHelper(baseURL: ApiEndPointUrls.apiBaseUrl).postHTTP(ApiEndPointUrls.loginUrl, 
     data);
    print("LoginRepository login $response");
    if(response.statusCode == 200){
     await SharedPreference.setString(SharedPreference.userAccessToken, response.data['token']);
     await SharedPreference.setInt(SharedPreference.userId, response.data['user_id']);
      return true;
    } else{
      return false;
    }
    } catch (e) {
      print("LoginRepository $e");
      return false;
    }
    
  }
}