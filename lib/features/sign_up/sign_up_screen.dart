import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/custom_text_field.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/sign_up/data/sign_up_controller.dart';
import 'package:fridge_app/features/sign_up/widgets/already_account_widget.dart';
import 'package:fridge_app/features/sign_up/widgets/term_and_policy_widget.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

// Usage Example
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignupController signupController;

  @override
  void initState() {
    super.initState();
    signupController = Get.put(SignupController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleW(20), vertical: scaleH(20)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  'sign_up'.tr,
                  style: getTextTheme().navigationText.copyWith(fontSize: scaleW(20)),
                ),
                VerticalGap(scaleH(30)),
                CustomTextField(
                  errorText: signupController.nameError,
                  label: 'full_name'.tr,
                  hintText: 'full_name'.tr,
                  controller: signupController.nameController,
                ),
                VerticalGap(scaleH(4)),
                CustomTextField(
                  errorText:signupController.emailError,
                  label: 'email'.tr,
                  hintText: 'xyz@gmail.com',
                  controller: signupController.emailController,
                ),
                                VerticalGap(scaleH(4)),
                CustomTextField(
                  errorText: signupController.mobileError,
                  label: 'mobile_number'.tr,
                  hintText: '+3581234567890'.tr,
                  controller: signupController.mobileController,
                  isPassword: false,
                ),
                VerticalGap(scaleH(4)),
                CustomTextField(
                  errorText: signupController.dobError,
                  label: 'date_of_birth'.tr,
                  hintText: 'DD/MM/YYY'.tr,
                  controller: signupController.dobController,
                  isPassword: false,
                ),
                                VerticalGap(scaleH(4)),

                CustomTextField(
                  errorText: signupController.passwordError,
                  label: 'password'.tr,
                  hintText: 'password'.tr,
                  controller: signupController.passwordController,
                  isPassword: true,
                ),
                               VerticalGap(scaleH(4)),

                CustomTextField(
                  errorText: signupController.confirmPasswordError,
                  label: 'confirm_password'.tr,
                  hintText: 'confirm_password'.tr,
                  controller: signupController.confirmPasswordController,
                  isPassword: true,
                ),
                VerticalGap(scaleH(10)),
                const TermsAndPrivacyText(),
                VerticalGap(scaleH(10)),
                CustomButton(
                  text: 'sign_up'.tr,
                  onPressed: () {
                    signupController.signup();
                  },
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: scaleH(10), horizontal: scaleW(50)),
                   borderRadius: 100,
                ),
                VerticalGap(scaleH(10)),
                AlreadyAccountWidget(onTap: () {
                  Get.back();
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
