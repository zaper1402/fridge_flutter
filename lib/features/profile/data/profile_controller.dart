import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/profile/data/profile_model.dart';
import 'package:fridge_app/features/profile/data/profile_repository.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  int userId = 0;
  Rxn<ProfileModel> profileModel = Rxn();
  @override
  void onReady() async {
    super.onReady();
    userId = (await SharedPreference.getInt(SharedPreference.userId)) ?? 0;
    getProfileData();
  }

  getProfileData() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
     profileModel.value = await ProfileRepository().getProfileData(userId);
      Get.back();
    } catch (e) {
      Get.back();
    }
  }
}
