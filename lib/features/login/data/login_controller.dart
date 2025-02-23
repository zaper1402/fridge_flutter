import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/login/data/repository/login_repository.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailError = RxString('');
  final passwordError = RxString('');

  Future<void> login({bool isGoogleSignin = false, String? googleEmail}) async {
    // Validate email and password
    if(!isGoogleSignin){
    if (!validateEmail(emailController.text)) {
      emailError.value = 'Invalid email';
      return;
    } else {
      emailError.value = '';
    }

    
    if (!validatePassword(passwordController.text)) {
      passwordError.value = 'Invalid password';
      return;
    } else {
      passwordError.value = '';
    }
    }

    // Show loading dialog
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );

    try {
      // Call login API
      final isSuccess = await LoginRepository().login(
        isGoogleSignin ? googleEmail ?? emailController.text :
        emailController.text, passwordController.text,
      isGoogleSignin: isGoogleSignin); 

      // Check API response
      if (isSuccess) {
        // Navigate to homepage
        Get.back();
        AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
      } else {
        // Show error message (if any)
        Get.back();
        Get.snackbar('Error', 'Login failed');
      }

    } catch (e) {
      // Handle error
      Get.back();
      Get.snackbar('Error', 'An error occurred during login');
    }
    
  }

  bool validateEmail(String email) {
    // Implement your email validation logic here
    // For example, using a regular expression
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.([a-zA-Z]{2,})$').hasMatch(email);
  }

  bool validatePassword(String password) {
    // Implement your password validation logic here
    // For example, minimum length, special characters, etc.
    return password.length >= 6; 
  }
}