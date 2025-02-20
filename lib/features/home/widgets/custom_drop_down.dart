import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/home/data/data/drop_down_data.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<DropDownData> dataList;
  final String hintText;
  final String heading;
  final Function(String id) onSelect;
  const CustomDropdown(
      {super.key,
      required this.dataList,
      required this.hintText,
      required this.heading,
      required this.onSelect});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(widget.heading,
            style: getTextTheme().defaultText.copyWith(
                color: textBrownColor,
                fontWeight: FontWeight.w500,
                fontSize: scaleW(14))),
        VerticalGap(scaleH(10)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: getTextTheme().defaultText.copyWith(color: borderColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: scaleW(12), vertical: scaleH(8)),
          ),
          value: selectedItem,
          items: widget.dataList.map((DropDownData item) {
            return DropdownMenuItem<String>(
              value: item.id,
              child: CustomText(
                item.name,
                style:
                    getTextTheme().defaultText.copyWith(color: textBrownColor),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue;
            });
            widget.onSelect(newValue ?? '');
          },
        ),
      ],
    );
  }
}
