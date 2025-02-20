import 'package:flutter/material.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/sign_up/data/model/user_model.dart';
import 'package:fridge_app/features/sign_up/data/repository/signup_repository.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final dobController = TextEditingController(); // Date of birth
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameError = RxString('');
  final emailError = RxString('');
  final mobileError = RxString('');
  final dobError = RxString('');
  final passwordError = RxString('');
  final confirmPasswordError = RxString('');

  Future<void> signup() async {
    // Validate all fields
    if (!validateName(nameController.text)) {
      nameError.value = 'Invalid name';
      return;
    } else {
      nameError.value = '';
    }

    if (!validateEmail(emailController.text)) {
      emailError.value = 'Invalid email';
      return;
    } else {
      emailError.value = '';
    }

    if (!validateMobile(mobileController.text)) {
      mobileError.value = 'Invalid mobile number';
      return;
    } else {
      mobileError.value = '';
    }

    if (!validateDOB(dobController.text)) {
      dobError.value = 'Invalid date of birth';
      return;
    } else {
      dobError.value = '';
    }

    if (!validatePassword(passwordController.text)) {
      passwordError.value = 'Invalid password';
      return;
    } else {
      passwordError.value = '';
    }

    if (!validateConfirmPassword(
        passwordController.text, confirmPasswordController.text)) {
      confirmPasswordError.value = 'Passwords do not match';
      return;
    } else {
      confirmPasswordError.value = '';
    }

    // Show loading dialog
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );

    try {
      // Call signup API
      final isSuccess = await SignUpRepository().signup(UserModel(
          email: emailController.text,
          name: nameController.text,
          phoneNumber: mobileController.text,
          dob: dobController.text,
          password: passwordController.text));

      // Check API response
      if (isSuccess) {
        Get.back();
        AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
      } else {
        // Show error message (if any)
        Get.back();
        Get.snackbar('Error', 'Signup failed');
      }
    } catch (e) {
      // Handle error
      Get.back();
      Get.snackbar('Error', 'An error occurred during signup');
    } 
  }

  bool validateName(String name) {
    return name.trim().isNotEmpty; // Basic name validation
  }

  bool validateEmail(String email) {
    return RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.([a-zA-Z]{2,})$')
        .hasMatch(email);
  }

  bool validateMobile(String mobile) {
    return mobile.length == 15; // Example: 10-digit mobile number
  }

  bool validateDOB(String dob) {
    try {
      DateFormat('yyyy/MM/dd').parse(dob); // Check if date can be parsed
      return true;
    } catch (e) {
      return false;
    }
  }

  bool validatePassword(String password) {
    return password.length >= 6; // Example: Minimum 8 characters
  }

  bool validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
