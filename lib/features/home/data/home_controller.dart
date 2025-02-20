import 'package:flutter/material.dart';
import 'package:fridge_app/core/constants/assets.dart';
import 'package:fridge_app/features/common_widgets/loading_widget.dart';
import 'package:fridge_app/features/home/data/data/drop_down_data.dart';
import 'package:fridge_app/features/home/data/data/entry_data.dart';
import 'package:fridge_app/features/home/data/data/inventory_model.dart';
import 'package:fridge_app/features/home/data/data/product_item_request.dart';
import 'package:fridge_app/features/home/data/repository/home_repository.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:fridge_app/routing/router.dart';
import 'package:fridge_app/storage/shared_preference.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<Inventory> categories = RxList([]);
  TextEditingController productName = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController subnameController = TextEditingController();
  String selectedUnit = '';
  String selectedCategory = '';
  String selectedAllergy = '';
  Rxn<DateTime> expiryDate = Rxn();
  TextEditingController productBrand = TextEditingController();
  List<DropDownData> categoryList = [];
  List<DropDownData> quantityList = [];
  List<DropDownData> allergyList = [];

  RxBool isInventroyEmpty = RxBool(true);
  int userId = 0;

  @override
  onInit() async {
    super.onInit();
    userId = (await SharedPreference.getInt(SharedPreference.userId)) ?? 0;
    getDropdownData();
  }

  @override
  onReady() async {
    super.onReady();
    userId = (await SharedPreference.getInt(SharedPreference.userId)) ?? 0;
    getHomeInventoryList();
  }

  Future<DateTime?> showCalendarPopup(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return selectedDate;
  }

  getHomeInventoryList() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    try {
      List<Inventory>? inventory =
          await HomeRepository().homeInventoryList(userId);
      if (inventory?.isEmpty == true) {
        isInventroyEmpty.value = true;
      } else {
        for (Inventory inventoryItem in inventory ?? []) {
          inventoryItem.image = getInventoryImage(inventoryItem.name ?? '');
        }
        categories.clear();
        categories.addAll(inventory ?? []);
      }
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  Future addProductData() async {
    if (validateProduct(ProductItemRequest(
        name: productName.text,
        brand: productBrand.text,
        quantity: double.parse(productQuantity.text),
        quantityType: selectedUnit,
        category: selectedCategory,
        allergy: selectedAllergy == "None" ? null : selectedAllergy,
        subname: subnameController.text,
        expiry: DateTime.now(),
        userId: userId))) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(),
      );
    }
    try {
      bool isSuccess = await HomeRepository().addProductData(ProductItemRequest(
          name: productName.text,
          brand: productBrand.text,
          quantity: double.parse(productQuantity.text),
          quantityType: selectedUnit,
          category: selectedCategory,
          allergy: selectedAllergy == "None" ? null : selectedAllergy,
          expiry: expiryDate.value,
          userId: userId));
      Get.back();
      if (isSuccess) {
        Get.snackbar('Success', 'Data Added Successfully', duration: const Duration(seconds: 1));
        productName.text = '';
        productBrand.text = '';
        productQuantity.text = '';
        selectedUnit = '';
        selectedAllergy = '';
        selectedCategory = '';
        expiryDate.value = null;
      }
    } catch (e) {
      Get.back();
    }
  }

  Future updateEntryQuantity(List<EntryData> entryData) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );

    try {
      bool isSuccess = await HomeRepository().updateEntryQuantity(entryData);
      Get.back();
      if (isSuccess) {
        Get.snackbar('Success', 'Data Added Successfully',
            duration: const Duration(seconds: 1));
        Future.delayed(const Duration(seconds: 2), () {
          AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
          // getHomeInventoryList();
        });
      }
    } catch (e) {
      Get.back();
    }
  }

  bool validateProductName(String name) {
    if (name.isEmpty) {
      print("Product name cannot be empty.");
      return false;
    }
    return true;
  }

  // Function to validate quantity (must be a double)
  bool validateQuantity(double quantity) {
    if (quantity <= 0) {
      return false;
    }
    return true;
  }

  // Function to validate quantity type
  bool validateQuantityType(String quantityType) {
    if (quantityType.isNotEmpty) {
      return false;
    }
    return true;
  }

  // Function to validate brand name
  bool validateBrandName(String brand) {
    if (brand.isEmpty) {
      return false;
    }
    return true;
  }

  // Function to validate all fields together
  bool validateProduct(ProductItemRequest product) {
    return validateProductName(product.name) &&
        validateQuantity(product.quantity) &&
        validateQuantityType(product.quantityType) &&
        validateBrandName(product.brand);
  }

  String getInventoryImage(String name) {
    switch (name.toLowerCase()) {
      case 'fruit':
        return fruits; // Assuming fruits is a variable holding the image name
      case 'vegetable':
        return vegetables;
      case 'dairy':
        return dairy;
      case 'meat & fish':
        return meatFish;
      case 'ingredients & spices':
        return spices;
      case 'grain':
        return grains;
      default:
        return '';
    }
  }

  getDropdownData() async {
    dynamic response = await HomeRepository().getDropDownData();
    print("category List ${response['category']}");
    print("quantity List ${response['quantity']}");
    print("allergy List ${response['allergy']}");
    categoryList = (response['category'] as List)
        .map((e) => DropDownData.fromJson(e))
        .toList();
    quantityList = (response['quantity'] as List)
        .map((e) => DropDownData.fromJson(e))
        .toList();
    allergyList = (response['allergy'] as List)
        .map((e) => DropDownData.fromJson(e))
        .toList();
    // allergyList.insert(0, DropDownData(id: 'None', name: 'None'));
  }
}
