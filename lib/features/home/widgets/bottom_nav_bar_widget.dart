import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/themes/colors.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int index)? onTap;
  const BottomNavBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent, // Make the BottomAppBar transparent
      elevation: 0, // Remove default elevation
      child: Container(
        margin: EdgeInsets.only(bottom: scaleH(30), left: scaleW(44), right: scaleW(44)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          color: primaryColor
        ),
        padding: EdgeInsets.symmetric(vertical: scaleH(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset(homeIcon, width: scaleW(24), height: scaleW(24),),
              onPressed: () {
                if(onTap != null){
                  onTap!(0);
                }
              },
            ),
            IconButton(
              icon: Image.asset(favoriteIcon,width: scaleW(24), height: scaleW(24),),
              onPressed: () {
                if(onTap != null){
                  onTap!(1);
                }
              },
            ),
            IconButton(
              icon: Image.asset(notificationsIcon,width: scaleW(24), height: scaleW(24),),
              onPressed: () {
                if(onTap != null){
                  onTap!(2);
                }
              },
            ),
            IconButton(
              icon: Image.asset(profileIcon,width: scaleW(24), height: scaleW(24),),
              onPressed: () {
                if(onTap != null){
                  onTap!(3);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}