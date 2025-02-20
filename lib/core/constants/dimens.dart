import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double widgetModeHeight = 1080.0;
double widgetModeWidth = 300.0;

int mobileHeight =  740;
int mobileWidth =  360;

class Dimens {

  static double get screenHeight {
    return PlatformDispatcher.instance.views.first.physicalSize.height /
        PlatformDispatcher.instance.views.first.devicePixelRatio;
  }

  static double get screenWidth {
    return PlatformDispatcher.instance.views.first.physicalSize.width /
        PlatformDispatcher.instance.views.first.devicePixelRatio;
  }
}

double scaleH(double value) {

    return value * ((Dimens.screenHeight) / mobileHeight);
  
}

double scaleWidthPercentage(double? percent, BuildContext context) {
  return MediaQuery.of(context).size.width * (percent ?? 1);
}

double scaleHeightPercentage(double? percent, BuildContext context) {
  return MediaQuery.of(Get.context!).size.height * (percent ?? 1);
}

double scaleWidthP(int width, BuildContext context) {
    return MediaQuery.of(context).size.width * ((width / mobileWidth));
  
}

double scaleHeightP(int height, BuildContext context) {
    return MediaQuery.of(Get.context!).size.height * ((height / mobileHeight));
  
}

double scaleW(double value) {
    return value * ((Dimens.screenWidth) / mobileWidth);
  
}
