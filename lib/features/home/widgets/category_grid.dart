import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/dimens.dart';
import 'package:fridge_app/features/common_widgets/custom_text.dart';
import 'package:fridge_app/features/home/data/data/inventory_model.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/themes/app_theme.dart';
import 'package:fridge_app/themes/colors.dart';

class CategoryGrid extends StatelessWidget {
  final List<Inventory> categories; // Category list passed from outside

  const CategoryGrid({super.key, required this.categories}); // Constructor to receive the list

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(scaleW(20)),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: scaleW(15),
        mainAxisSpacing: scaleH(50),
        childAspectRatio: 0.95,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryItem(categories[index]);
      },
    );
  }

  Widget _buildCategoryItem(Inventory item) {
    return InkWell(
      onTap: () {
        // Handle category tap
        AppRouting().routeTo(NameRoutes.groceryScreen, arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lightPinkColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: SizedBox(
                height: scaleW(100),
                width: double.infinity,
                child: Image.asset(
                  item.image ?? '',
                  
                  fit: BoxFit.cover,
                  errorBuilder: (context, object, stackTrace) {
                    return const Center(child: Icon(Icons.error));
                  },
                  
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(scaleW(4)),
              child: CustomText(
                item.name ?? '',
                textAlign: TextAlign.center,
                style: getTextTheme().defaultText.copyWith(color: textBrownColor, fontSize: scaleW(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String image; // Can be asset path or URL
  final String label;

  CategoryItem({required this.image, required this.label});
}