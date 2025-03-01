import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/cuisine_category/data/data/ingredient_model.dart';
import 'package:fridge_app/features/home/data/data/entry_data.dart';
import 'package:fridge_app/features/home/data/data/inventory_model.dart';
import 'package:fridge_app/features/home/data/home_controller.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroceryDetailsScreen extends StatefulWidget {
  const GroceryDetailsScreen({super.key});

  @override
  State<GroceryDetailsScreen> createState() => _GroceryDetailsScreenState();
}

class _GroceryDetailsScreenState extends State<GroceryDetailsScreen> {
  ProductItem? product;

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments;
    if (arguments != null && arguments is ProductItem) {
      product = arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
              margin: EdgeInsets.only(bottom: scaleH(20)),
              width: double.infinity,
              child: CustomButton(
                text: "${'category:'.tr}${product?.product?.category ?? ''}",
                onPressed: () {
                  Get.back();
                },
                backgroundColor: primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    vertical: scaleH(14), horizontal: scaleW(24)),
                borderRadius: 100,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: product?.entries?.length ?? 0,
                itemBuilder: (context, index) {
                  String productName =
                      (product?.product?.subname ?? '').isNotEmpty
                          ? product?.product?.subname ?? ''
                          : product?.product?.name ?? '';
                  return _buildItemCard(productName, product?.entries?[index],
                      deleteItem: () async {
                    Future.delayed(const Duration(seconds: 1), () {
                      product?.entries?.removeAt(index);
                      setState(() {});
                    });
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
              margin: EdgeInsets.only(bottom: scaleH(20)),
              width: double.infinity,
              child: CustomButton(
                text: 'done'.tr,
                onPressed: () async {
                  List<EntryData> entryData = [];
                  for (Entry entry in product?.entries ?? []) {
                    entryData.add(EntryData(
                        entryId: entry.id ?? 0,
                        quantity: entry.quantity ?? 0,
                        quantityType: entry.quantityType));
                  }
                  await Get.find<HomeController>()
                      .updateEntryQuantity(entryData);
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

  Widget _buildItemCard(String productName, Entry? item,
      {Function? deleteItem}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(productName,
                    style: getTextTheme()
                        .navigationText
                        .copyWith(fontSize: scaleW(20))),
                VerticalGap(scaleH(4)),
                CustomText(
                    'Expiry: ${DateFormat("dd/MM/yyy").format((item?.expiryDate) ?? DateTime.now())}',
                    style: getTextTheme()
                        .appTextStyle
                        .copyWith(color: Colors.grey, fontSize: scaleW(10))),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: scaleW(10)),
                child: CustomText(
                    "${((item?.quantity) ?? 0).toDouble().toStringAsFixed(1)} ${item?.quantityType ?? ''}",
                    style: getTextTheme()
                        .defaultText
                        .copyWith(color: textBrownColor)),
              ),
              InkWell(
                onTap: () {
                  AppRouting().routeTo(NameRoutes.updateIngredientScreen,
                      onPopCallback: (value) {
                    var qt = value['qt'];
                    String unit = value['unit'].toString();
                    if (qt is double) {
                      if (qt <= 0) {
                        if (deleteItem != null) {
                          deleteItem();
                          return;
                        }
                      }
                      item!.quantity = qt.toDouble();
                    }
                    item?.quantityType = unit;
                    setState(() {});
                  },
                      arguments: IngredientModel(
                          id: item?.id,
                          name: productName,
                          quantity: item?.quantity?.toDouble(),
                          unit: item?.quantityType));
                },
                child: const Icon(Icons.edit),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Item {
  final String name;
  int quantity;
  final String expiry;

  Item({required this.name, required this.quantity, required this.expiry});
}
