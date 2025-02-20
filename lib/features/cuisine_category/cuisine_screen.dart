import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/common_app_bar.dart';
import 'package:fridge_app/features/cuisine_category/data/cuisine_controller.dart';
import 'package:fridge_app/features/cuisine_category/widgets/dish_card.dart';
import 'package:fridge_app/features/home/widgets/empty_fridge_message.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';
import 'package:get/get.dart';

class CuisineScreen extends StatefulWidget {
  const CuisineScreen({super.key});

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? cuisineId;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is int) {
      cuisineId = Get.arguments;
    }
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      Get.find<CuisineController>()
          .getCuisineRecipeList(_tabController.index + 1, cuisineId ?? 0);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (cuisineId != null) {
        Get.find<CuisineController>().getCuisineRecipeList(1, cuisineId ?? 0);
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('cuisine_recipe'.tr, actions: [
        InkWell(
          onTap: () {
            AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
          },
          child: Padding(
            padding: EdgeInsets.all(scaleW(10)),
            child: Image.asset(
              homeIcon,
              width: scaleW(20),
              height: scaleW(20),
              color: primaryColor,
            ),
          ),
        )
      ]),
      body: Column(
        children: [
          CustomTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                DishesList(),
                DishesList(),
                DishesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final TabController tabController;

  const CustomTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: scaleH(10)),
      padding: EdgeInsets.symmetric(horizontal: scaleW(40)),
      height: scaleH(30),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.pinkAccent,
        indicator: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelStyle: getTextTheme().defaultText.copyWith(fontSize: scaleW(12)),
        tabs: [
          Tab(
            text: "breakfast".tr,
            iconMargin: EdgeInsets.zero,
          ),
          Tab(text: "lunch".tr),
          Tab(text: "dinner".tr),
        ],
      ),
    );
  }
}

class DishesList extends GetView<CuisineController> {
  const DishesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.cuisineRecipeModelList.isEmpty
          ?  Container(
            color: Colors.white,
            child: const EmptyFridgeMessage(
                emptyString: 'No Recipe Available for now.'),
          )
          : GridView.builder(
              padding: EdgeInsets.all(scaleW(10)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: scaleW(10),
                mainAxisSpacing: scaleH(20),
                childAspectRatio: 0.7,
              ),
              itemCount: controller.cuisineRecipeModelList.length,
              itemBuilder: (context, index) {
                final dish = controller.cuisineRecipeModelList[index];
                return DishCard(
                  recipeModel: dish,
                  onFavClick: () {
                    controller.onFavClick(index);
                    
                  },
                );
              },
            ),
    );
  }
}
