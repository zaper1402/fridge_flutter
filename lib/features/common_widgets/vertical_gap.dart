import 'package:flutter/material.dart';

class VerticalGap extends StatelessWidget {
  final double value;

  const VerticalGap(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}
