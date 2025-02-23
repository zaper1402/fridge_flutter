import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_button.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/horizontal_gap.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/cuisine_category/data/controllers/ingredient_controller.dart';
import 'package:fridge_app/features/cuisine_category/data/data/ingredient_model.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class FridgeIngredientScreen extends StatefulWidget {
  const FridgeIngredientScreen({super.key});

  @override
  State<FridgeIngredientScreen> createState() => _FridgeIngredientScreenState();
}

class _FridgeIngredientScreenState extends State<FridgeIngredientScreen> {
  IngredientController ingredientController = Get.put(IngredientController());
  int cuisineId = 0;

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments;
    if(arguments is int){
      ingredientController.recipeId = arguments;
    }
    print("ingredientController argument $arguments");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Ingredients'),
      body: Obx(
        () => ingredientController.ingredientList.isEmpty ? 
        const Center(
          child: EmptyFridgeMessage(emptyString: 'No Ingredients Found'),
        )
         : Column(
          children: [
            VerticalGap(scaleH(20)),
            Expanded(child: ListView.builder(
              itemCount: ingredientController.ingredientList.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
              return _buildItem(index);
            })),
            Container(
              padding: EdgeInsets.symmetric(horizontal: scaleW(20)),
              margin: EdgeInsets.only(bottom: scaleH(20)),
              width: double.infinity,
              child: CustomButton(
                text: 'done'.tr,
                onPressed: () async {
                 bool isSuccess = await ingredientController.updateIngredientData();
                 if(isSuccess){
                  Future.delayed(const Duration(milliseconds: 700), (){
                    AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
                  });
                 } else{
                  Get.snackbar('Could Not update ingredients', "Please try again after sometime.");
                 }
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

  _buildItem(int index) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: scaleH(6), horizontal: scaleW(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomText(
              ingredientController.ingredientList.elementAt(index).name ?? '',
              style: getTextTheme()
                  .navigationText
                  .copyWith(fontSize: scaleW(20)),
            ),
          ),
          CustomText(
            (ingredientController.ingredientList.elementAt(index).quantity ?? 1).toInt().toString(),
            style: getTextTheme()
                .navigationText
                .copyWith(fontSize: scaleW(16), color: textBrownColor),
                textAlign: TextAlign.end,
          ),
          HorizontalGap(scaleW(10)),
          InkWell(
            onTap: (){
              ingredientController.ingredientList.elementAt(index).readyOnlyUnit = true;
              AppRouting().routeTo(NameRoutes.updateIngredientScreen, onPopCallback: (value){
              var qt = value['qt'];
              String unit = value['unit'].toString();
              if(qt is int){
                ingredientController.ingredientList.elementAt(index).quantity = qt;
                ingredientController.ingredientList.elementAt(index).unit = unit;
                ingredientController.ingredientList.refresh();
                ingredientController.updatedList.add(IngredientModel(
                  id: ingredientController.ingredientList.elementAt(index).id,
                  quantity: ingredientController.ingredientList.elementAt(index).quantity,
                  unit: unit
                ));
              }
            }, arguments: ingredientController.ingredientList.elementAt(index));
            },
            child:  const Icon(Icons.edit),
          )
          // IconButton(onPressed: () {
          //   AppRouting().routeTo(NameRoutes.updateIngredientScreen, onPopCallback: (value){
          //     var qt = value['qt'];
          //     String unit = value['unit'].toString();
          //     if(qt is int){
          //       ingredientController.ingredientList.elementAt(index).quantity = qt;
          //       ingredientController.ingredientList.elementAt(index).unit = unit;
          //       ingredientController.ingredientList.refresh();
          //       ingredientController.updatedList.add(IngredientModel(
          //         id: ingredientController.ingredientList.elementAt(index).id,
          //         quantity: ingredientController.ingredientList.elementAt(index).quantity,
          //         unit: unit
          //       ));
          //     }
          //   });
          // }, icon: const Icon(Icons.edit))
        ],
      ),
    );
  }
}
