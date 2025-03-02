import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/profile/data/profile_controller.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
  @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // For scrollability if content overflows
      padding: const EdgeInsets.all(20.0),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomText(
              'Profile',
              style:
                  getTextTheme().navigationText.copyWith(color: primaryColor),
            ),
            // VerticalGap(scaleH(20)),
            // CustomText(
            //   'Complete Your Profile',
            //   style:
            //       getTextTheme().navigationText.copyWith(color: textBrownColor),
            // ),
            VerticalGap(scaleH(20)),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: lightPinkColor, // Placeholder background color
                child: SizedBox(
                  width: scaleW(40),
                  height: scaleW(40),
                  child: Image.asset(profileImage),
                ),
              ),
            ),
            VerticalGap(scaleH(20)),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem('Full Name',
                      profileController.profileModel.value?.name ?? ''),
                  _buildProfileItem('Email',
                      profileController.profileModel.value?.email ?? ''),
                  _buildProfileItem('Mobile Number',
                      '${profileController.profileModel.value?.phoneNumber}'),
                  _buildProfileItem(
                      'Date Of Birth',
                      (DateFormat('dd/MM/yyy').format(
                          profileController.profileModel.value?.dateOfBirth ??
                              DateTime.now()))),
                ],
              ),
            ),
            VerticalGap(scaleH(20)),
            Center(
              // Center the button
              child: CustomButton(
                  text: 'Logout',
                  onPressed: () {
                    showLogoutDialog(context);
                  },
                  padding: EdgeInsets.symmetric(
                      vertical: scaleH(12), horizontal: scaleW(40)),
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  borderRadius: 100),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            "Logout",
            style: getTextTheme().defaultText,
          ),
          content: CustomText(
            "Are you sure you want to logout?",
            style: getTextTheme().defaultText.copyWith(color: textBrownColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel logout
              },
              child: Text("Cancel", style: getTextTheme().defaultText.copyWith(color: greyColor),),
            ),
            TextButton(
              onPressed: () async {
                await SharedPreference.clearAllData();
                Navigator.of(context).pop(true); // Confirm logout
                Future.delayed(const Duration(seconds: 1), () {
                  AppRouting().offAllNavigateTo(NameRoutes.loginScreen);
                });
              },
              child: Text("Logout", style: TextStyle(color: primaryColor)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleH(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label,
            style: getTextTheme()
                .navigationText
                .copyWith(color: textBrownColor, fontSize: scaleW(14)),
          ),
          VerticalGap(scaleH(10)),
          Container(
            width: double.infinity,
            // Added Container for styling
            padding: EdgeInsets.symmetric(
                horizontal: scaleW(15), vertical: scaleH(12)),
            decoration: BoxDecoration(
              color: lightPinkColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: CustomText(
              value,
              style: getTextTheme()
                  .defaultText
                  .copyWith(color: textBrownColor.withOpacity(0.7)),
            ), // Display the value as Text
          ),
        ],
      ),
    );
  }
}
