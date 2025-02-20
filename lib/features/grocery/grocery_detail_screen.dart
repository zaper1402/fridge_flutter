import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
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
    if(arguments != null && arguments is ProductItem){
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
                  padding: EdgeInsets.symmetric(vertical: scaleH(14), horizontal: scaleW(24)),
                   borderRadius: 100,
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: product?.entries?.length ?? 0,
                itemBuilder: (context, index) {
                  return _buildItemCard(product?.product?.name ??'' , product?.entries?[index]);
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
                      entryData.add(EntryData(entryId: entry.id ?? 0, quantity: entry.quantity ?? 0));
                    }
                    await Get.find<HomeController>().updateEntryQuantity(entryData);
                    
                  },
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: scaleH(14), horizontal: scaleW(24)),
                   borderRadius: 100,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(String productName, Entry? item) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  productName,
                  style: getTextTheme().navigationText.copyWith(fontSize: scaleW(20))
                ),
                VerticalGap(scaleH(4)),
                CustomText(
                  'Expiry: ${DateFormat("dd/mm/yyy").format((item?.expiryDate) ?? DateTime.now())}',
                  style: getTextTheme().appTextStyle.copyWith(color: Colors.grey, fontSize: scaleW(10))
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: scaleW(36),
                height: scaleW(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightBlueColor,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.remove, color: Colors.grey,),
                  onPressed: () {
                    // Handle quantity decrement
                    item?.quantity = (item.quantity ?? 1) - 1;
                    setState(() {
                      
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: scaleW(10)),
                child: CustomText(
                  item?.quantity.toString() ?? '',
                  style: getTextTheme().defaultText.copyWith(color: textBrownColor)
                ),
              ),
              Container(
                width: scaleW(36),
                height: scaleW(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add, color: Colors.white,),
                  onPressed: () {
                    // Handle quantity decrement
                    item?.quantity = (item.quantity ?? 1) + 1;
                    setState(() {
                      
                    });
                  },
                ),
              ),
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