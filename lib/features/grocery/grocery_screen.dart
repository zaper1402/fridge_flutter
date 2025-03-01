import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/grocery/widgets/grocery_item.dart';
import 'package:fridge_app/features/home/data/data/inventory_model.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';



// Main screen widget
class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  Inventory? inventory;

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments;
    if(arguments != null && arguments is Inventory){
      inventory = arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(inventory?.name ?? ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: inventory?.products?.length,
                itemBuilder: (context, index){
                  Product? product = inventory?.products?[index].product;

                  if(product == null) return const SizedBox.shrink();
                  if(inventory?.products?[index].entries?.isEmpty ?? true){
                    return const SizedBox.shrink();
                  }
                  String productName = (product.subname ??'').isNotEmpty ?product.subname ??'' : product.name ??'';
                return VegetableItem(name: productName, quantity: "${(product.totalQuantity ?? 0).toDouble()} ${product.quantityType ?? ''}", onTap: (){
                    AppRouting().routeTo(NameRoutes.groceryDetailsScreen, arguments: inventory?.products?[index]);
                  },);
              }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
              margin: EdgeInsets.only(bottom: scaleH(20)),
                width: double.infinity,
                child: CustomButton(
                  text: 'done'.tr,
                  onPressed: () {
                    Get.back();
                  },
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: scaleH(14), horizontal: scaleW(24)),
                   borderRadius: 100,
                ),
              ),
          ],
        ),
      ),
    );
  }
}