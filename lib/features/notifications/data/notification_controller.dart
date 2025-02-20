import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/notifications/data/model/notification_model.dart';
import 'package:fridge_app/features/notifications/repository/notification_repository.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notificationList = RxList([]);

  @override
  onReady(){
    super.onReady();
    getNotificationData();
  }

  getNotificationData() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      int userId = await SharedPreference.getInt(SharedPreference.userId) ?? 0;
      List<NotificationModel> notificationData =
          await NotificationRepository().getNotificationData(userId);
      notificationList.clear();
      notificationList.addAll(notificationData);
      Get.back();
    } catch (e) {
      Get.back();
    }
  }
}
