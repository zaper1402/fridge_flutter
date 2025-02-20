import 'package:flutter/material.dart';

class HorizontalGap extends StatelessWidget {
  final double value;

  const HorizontalGap(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}
