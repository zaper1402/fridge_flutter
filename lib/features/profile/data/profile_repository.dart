import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/features/profile/data/profile_model.dart';

class ProfileRepository{
  Future<ProfileModel?> getProfileData(int userId) async {
    try {
      dynamic response =
          await ApiBaseHelper().getHTTP(ApiEndPointUrls.profileInfoUrl,
          queryParameters: {"id" : userId});
        return ProfileModel.fromJson(response);
    } catch (e) {
      print("error profile $e");
      return null;
    }
  }
}