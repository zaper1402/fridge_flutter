import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/cuisine_category/data/data/ingredient_model.dart';
import 'package:fridge_app/features/home/data/data/entry_data.dart';
import 'package:fridge_app/features/home/data/home_controller.dart';
import 'package:fridge_app/features/home/widgets/custom_drop_down.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class UpdateIngredientScreen extends StatefulWidget {
  const UpdateIngredientScreen({super.key});

  @override
  State<UpdateIngredientScreen> createState() => _UpdateIngredientScreenState();
}

class _UpdateIngredientScreenState extends State<UpdateIngredientScreen> {
  String unitId = '';
  TextEditingController quantityController = TextEditingController();
  IngredientModel? ingredientModel;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is IngredientModel) {
      ingredientModel = Get.arguments;
      quantityController.text = (ingredientModel?.quantity ?? 1).toString();
      unitId = ingredientModel?.unit ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Update Ingredients', actions: [
        InkWell(
            onTap: () {
              showLogoutDialog(context);
            },
            child: SizedBox(
                width: scaleW(60),
                height: scaleW(60),
                child: Icon(
                  Icons.delete_outline,
                  size: scaleW(24),
                  color: Colors.red,
                )))
      ]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
        child: Column(
          children: [
            VerticalGap(scaleH(20)),
            _buildTextField("Quantity", "5", controller: quantityController),
            VerticalGap(scaleH(20)),
            ingredientModel?.readyOnlyUnit == true
                ? _buildTextField("Unit", "KG",
                    readyOnly: true,
                    controller:
                        TextEditingController(text: ingredientModel?.unit))
                : CustomDropdown(
                    dataList: Get.find<HomeController>().quantityList,
                    hintText: ingredientModel?.unit ?? 'gms',
                    heading: 'Unit',
                    onSelect: (id) {
                      unitId = id;
                    },
                  ),
            VerticalGap(scaleH(20)),
            Container(
              margin: EdgeInsets.only(bottom: scaleH(20)),
              width: double.infinity,
              child: CustomButton(
                text: 'done'.tr,
                onPressed: () async {
                  double qt = double.parse(quantityController.text);
                  if (qt <= 0) {
                    Get.snackbar('Warning',
                        'Quantity can not be zero please enter valid value.',
                        duration: const Duration(seconds: 2));
                    return;
                  }
                  Get.back(result: {
                    "qt": double.parse(quantityController.text),
                    "unit": unitId
                  });
                },
                backgroundColor: primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    vertical: scaleH(14), horizontal: scaleW(24)),
                borderRadius: 100,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool?> showLogoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            "Delete",
            style: getTextTheme().defaultText,
          ),
          content: CustomText(
            "Are you sure you want to delete?",
            style: getTextTheme().defaultText.copyWith(color: textBrownColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel logout
              },
              child: Text(
                "Cancel",
                style: getTextTheme().defaultText.copyWith(color: greyColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                List<EntryData> entryData = [];
                entryData.add(EntryData(
                    entryId: ingredientModel?.id ?? 0,
                    quantity: 0,
                    quantityType: ingredientModel?.unit));

                await (Get.isRegistered<HomeController>()
                        ? Get.find<HomeController>()
                        : Get.put(HomeController()))
                    .updateEntryQuantity(entryData, navigateHome: false);
              },
              child: Text("Delete", style: TextStyle(color: primaryColor)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, String hint,
      {required TextEditingController controller, bool readyOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label,
            style: getTextTheme().defaultText.copyWith(
                color: textBrownColor,
                fontWeight: FontWeight.w500,
                fontSize: scaleW(14))),
        VerticalGap(scaleH(10)),
        TextField(
          controller: controller,
          cursorColor: borderColor,
          readOnly: readyOnly,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: borderColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: borderColor)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: scaleW(16), vertical: scaleH(6)),
          ),
        ),
      ],
    );
  }
}
