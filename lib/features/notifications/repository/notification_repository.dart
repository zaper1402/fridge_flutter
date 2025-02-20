import 'package:fridge_app/api_service/api_service.dart';
import 'package:fridge_app/app/api_end_points.dart';
import 'package:fridge_app/features/notifications/data/model/notification_model.dart';

class NotificationRepository{
  Future<List<NotificationModel>> getNotificationData(int userId) async {
    try {
      dynamic response =
          await ApiBaseHelper().getHTTP(ApiEndPointUrls.expiryNotificationUrl, queryParameters: {
            "user_id" : userId
          });
        return (response as List).map((e) => NotificationModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}