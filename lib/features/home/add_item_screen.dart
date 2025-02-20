import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/home/data/data/category_data.dart';
import 'package:fridge_app/features/home/data/data/drop_down_data.dart';
import 'package:fridge_app/features/home/data/home_controller.dart';
import 'package:fridge_app/features/home/data/repository/home_repository.dart';
import 'package:fridge_app/features/home/widgets/custom_drop_down.dart';
import 'package:fridge_app/features/home/widgets/item_searchable_dropdown.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddItemScreen extends GetView<HomeController> {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(''),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: scaleW(20)), // Inner padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemSearchableDropdown(
                          searchController: controller.productName,
                          onSearch: (query) async {
                            List<CategoryData> data = await HomeRepository().productList(query);

                            return data.map((e) => e.name).toList();
                          },
                        ),
                        VerticalGap(scaleH(20)),
                        _buildTextField('Name', 'Milk',
                            controller: controller.subnameController),
                        VerticalGap(scaleH(20)),
                        _buildTextField('Quantity', '500',
                            controller: controller.productQuantity),
                        VerticalGap(scaleH(20)),
                        CustomDropdown(
                          dataList: controller.quantityList,
                          hintText: 'gms',
                          heading: 'Unit',
                          onSelect: (id) {
                            controller.selectedUnit = id;
                          },
                        ),
                        VerticalGap(scaleH(20)),
                        CustomDropdown(
                          dataList: controller.categoryList,
                          hintText: 'MILK',
                          heading: 'Category',
                          onSelect: (id) {
                            controller.selectedCategory = id;

                          },
                        ),
                        VerticalGap(scaleH(20)),
                        CustomDropdown(
                          dataList: controller.allergyList,
                          hintText: 'Apple',
                          heading: 'Allergy Product',
                          onSelect: (id) {
                            controller.selectedAllergy = id;
                          },
                        ),
                        VerticalGap(scaleH(20)),
                        _buildTextField('Brand', 'Optional',
                            controller: controller.productBrand),
                        VerticalGap(scaleH(20)),
                        CustomText('Expiry',
                            style: getTextTheme().defaultText.copyWith(
                                color: textBrownColor,
                                fontWeight: FontWeight.w500,
                                fontSize: scaleW(14))),
                        VerticalGap(scaleH(10)),
                        InkWell(
                          onTap: () async {
                            DateTime? date =
                                await controller.showCalendarPopup(context);
                            controller.expiryDate.value = date;
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: scaleW(10), vertical: scaleH(12)),
                            decoration: BoxDecoration(
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Obx(
                              () => CustomText(
                                controller.expiryDate.value != null
                                    ? DateFormat("dd/MM/yyy")
                                        .format(controller.expiryDate.value!)
                                    : 'Expiry',
                                style: getTextTheme().defaultText.copyWith(
                                    color: controller.expiryDate.value != null
                                        ? textBrownColor
                                        : borderColor),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: true,
                                focusColor: Colors.deepPurple,
                                fillColor: const MaterialStatePropertyAll(
                                    Colors.deepPurple),
                                onChanged: (value) {}),
                            CustomText(
                              'Go with Standard Expiry',
                              style: getTextTheme().defaultText.copyWith(
                                  color: textBrownColor, fontSize: scaleW(14)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalGap(scaleH(20)),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'done'.tr,
                    onPressed: () async {
                      await Get.find<HomeController>().addProductData();
                      Future.delayed(const Duration(seconds: 2), (){
                      Get.back();
                        Get.find<HomeController>().getHomeInventoryList();
                      });
                    },
                    backgroundColor: primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: scaleH(12), horizontal: scaleW(50)),
                    borderRadius: 100,
                  ),
                ),
                VerticalGap(scaleH(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {required TextEditingController controller}) {
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
