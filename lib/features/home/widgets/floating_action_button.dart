import 'package:flutter/material.dart';
import 'package:fridge_app/themes/colors.dart';

class AddIngredientButton extends StatelessWidget {
  final Function()? onPressed;
  const AddIngredientButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: greenColor,
      child: const Icon(Icons.add), // Example color
    );
  }
}