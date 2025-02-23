import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/custom_text_field.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/login/data/login_controller.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Usage Example
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: scaleW(20), vertical: scaleH(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                'login'.tr,
                style: getTextTheme()
                    .navigationText
                    .copyWith(fontSize: scaleW(20)),
              ),
              VerticalGap(scaleH(100)),
              CustomTextField(
                errorText: loginController.emailError,
                label: 'email'.tr,
                hintText: 'xyz@gmail.com',
                controller: loginController.emailController,
              ),
              VerticalGap(scaleH(16)),
              CustomTextField(
                errorText: loginController.passwordError,
                label: 'password'.tr,
                hintText: 'password'.tr,
                controller: loginController.passwordController,
                isPassword: true,
              ),
              VerticalGap(scaleH(70)),
              CustomButton(
                text: 'log_in'.tr,
                onPressed: () {
                  loginController.login();
                },
                backgroundColor: lightPinkColor,
                textColor: pinkTextColor,
                padding: EdgeInsets.symmetric(
                    vertical: scaleH(12), horizontal: scaleW(40)),
                borderRadius: 100,
              ),
              VerticalGap(scaleH(16)),
              CustomButton(
                text: 'sign_up'.tr,
                onPressed: () {
                  AppRouting().routeTo(NameRoutes.signupScreen);
                },
                backgroundColor: lightPinkColor,
                textColor: pinkTextColor,
                padding: EdgeInsets.symmetric(
                    vertical: scaleH(12), horizontal: scaleW(36)),
                borderRadius: 100,
              ),
              VerticalGap(scaleH(40)),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'continue_with_google'.tr,
                  onPressed: () async {
                    try {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    if(await googleSignIn.isSignedIn()){
                      print("already sign in ");
                      googleSignIn.signOut();
                    }
                    GoogleSignInAccount? signInAccount = await googleSignIn.signIn();
                    print("signInAccount ${await signInAccount?.authHeaders} ${signInAccount?.email} ${signInAccount?.displayName}");
                    if(signInAccount != null){
                    loginController.login(isGoogleSignin: true, googleEmail: signInAccount.email);
                    }
                    } catch (e, stackTrace) {
                      print("error $e $stackTrace");
                    }
                  },
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  icon: googleIcon,
                  padding: EdgeInsets.symmetric(
                      vertical: scaleH(14), horizontal: scaleW(24)),
                  borderRadius: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
