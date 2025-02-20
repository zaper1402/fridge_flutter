import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/features/notifications/data/notification_controller.dart';
import 'package:fridge_app/features/notifications/widgets/notification_item.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationController notificationController;

  @override
  void initState() {
    super.initState();
    notificationController = Get.put(NotificationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('expiry_notifications'.tr, showBackIcon: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => notificationController.notificationList.isEmpty
              ? const EmptyFridgeMessage(
                  emptyString: 'No Item is Expiring right now.')
              : ListView.builder(
                  itemCount: notificationController.notificationList.length,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                        itemName: notificationController
                                .notificationList[index].productName ??
                            '',
                        expiryMessage:
                            "Are Expiring In ${(notificationController.notificationList[index].expiryDate ?? DateTime.now()).difference(DateTime.now()).inDays} Day!");
                  }),
        ),
      ),
    );
  }
}
