import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/common_widgets/vertical_gap.dart';
import 'package:fridge_app/features/cuisine_category/data/cuisine_controller.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class CuisineCategoryScreen extends StatefulWidget {
  const CuisineCategoryScreen({super.key});

  @override
  State<CuisineCategoryScreen> createState() => _CuisineCategoryScreenState();
}

class _CuisineCategoryScreenState extends State<CuisineCategoryScreen> {
  CuisineController cuisineController = Get.put(CuisineController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      cuisineController.getCuisineList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('pick_cuisine_type'.tr),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: scaleW(30), vertical: scaleH(10)),
        child: Obx(
          () => cuisineController.cuisineModelList.isEmpty ? 
           const EmptyFridgeMessage(
            emptyString: "No Cuisine Avaliable Right now.",
           )
           : Column(
            children: [
              SizedBox(
                height: scaleH(160),
                width: double.infinity,
                child: CategoryCard(
                  showTextUp: true,
                  onTap: () {
                    AppRouting().routeTo(NameRoutes.cuisineScreen, arguments: cuisineController.cuisineModelList[0].id);
                  },
                  name: cuisineController.cuisineModelList[0].name ?? '',
                  image: cuisineController.cuisineModelList[0].imageUrl ?? '',
                ),
              ),
              VerticalGap(scaleH(20)),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: scaleW(40),
                    mainAxisSpacing: 12,
                  ),
                  itemCount: cuisineController.cuisineModelList.length - 1,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      onTap: () {
                        AppRouting().routeTo(NameRoutes.cuisineScreen, arguments: cuisineController.cuisineModelList[index + 1].id);
                      },
                      name: cuisineController.cuisineModelList[index + 1].name ?? '',
                      image: cuisineController.cuisineModelList[index + 1].imageUrl ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String image;
  final bool showTextUp;
  final void Function()? onTap;

  const CategoryCard(
      {super.key,
      required this.name,
      required this.image,
      this.showTextUp = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          if (showTextUp)
            Padding(
              padding: EdgeInsets.only(bottom: scaleH(10)),
              child: CustomText(name,
                  style: getTextTheme().defaultText.copyWith(
                      color: textBrownColor, fontWeight: FontWeight.w500)),
            ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(image,
                  fit: BoxFit.cover,
                width: double.infinity,);
                },
              ),
            ),
          ),
          if (!showTextUp)
            Padding(
              padding: EdgeInsets.all(scaleW(8)),
              child: CustomText(name,
                  style: getTextTheme().defaultText.copyWith(
                      color: textBrownColor, fontWeight: FontWeight.w500)),
            ),
        ],
      ),
    );
  }
}
