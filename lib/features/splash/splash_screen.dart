import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:fridge_app/themes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _checkForUserLogin();
    });
  }

  _checkForUserLogin() async {
   String? userAccessToken = await SharedPreference.getString(SharedPreference.userAccessToken) ?? "";
   int? userId =  await SharedPreference.getInt(SharedPreference.userId);
   print("_checkForUserLogin $userAccessToken $userId");
   if((userAccessToken.isNotEmpty) && (userId != null)){
    AppRouting().offAndNavigateTo(NameRoutes.homeScreen);
   } else{
    AppRouting().offAndNavigateTo(NameRoutes.loginScreen);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Image.asset(splashIcon),
    );
  }
}