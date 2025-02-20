import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/themes/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
          child: Container(
            width: scaleW(100),
          height: scaleW(100),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
  }
}