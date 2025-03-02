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
  int selectedProductId = 0;
  String selectedAllergy = '';
  Rxn<DateTime> expiryDate = Rxn();
  TextEditingController productBrand = TextEditingController();
  List<DropDownData> categoryList = [];
  List<DropDownData> quantityList = [];
  List<DropDownData> allergyList = [];
  RxBool isStandardExpiry = RxBool(true);
  RxBool isAddProductInprogress = RxBool(false);

  RxBool isInventroyEmpty = RxBool(true);
  int userId = 0;
  RxString userName = RxString('');

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
      HomeInventory? homeInventory =
          await HomeRepository().homeInventoryList(userId);
      List<Inventory>? inventory = homeInventory?.inventory;
      userName.value = homeInventory?.userName ?? 'User';
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

  Future<bool> addProductData() async {
    isAddProductInprogress.value = true;
    if (validateProduct(ProductItemRequest(
        id: selectedProductId,
        brand: productBrand.text,
        quantity: productQuantity.text.isNotEmpty
            ? double.parse(productQuantity.text)
            : 0,
        quantityType: selectedUnit,
        subname: subnameController.text,
        expiry: isStandardExpiry.isFalse ? expiryDate.value : null,
        userId: userId))) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(),
      );
      try {
        bool isSuccess = await HomeRepository().addProductData(
            ProductItemRequest(
                id: selectedProductId,
                brand: productBrand.text,
                quantity: double.parse(productQuantity.text),
                quantityType: selectedUnit,
                expiry: isStandardExpiry.isFalse ? expiryDate.value : null,
                subname: subnameController.text,
                userId: userId));
        Get.back();
        if (isSuccess) {
          Get.snackbar('Success', 'Data Added Successfully',
              duration: const Duration(seconds: 1));
          productName.text = '';
          productBrand.text = '';
          productQuantity.text = '';
          selectedUnit = '';
          selectedAllergy = '';
          selectedCategory = '';
          expiryDate.value = null;
          subnameController.text = '';
          return true;
        }
      } catch (e) {
        Get.back();
      }
    }
    isAddProductInprogress.value = false;
    return false;
  }

  Future updateEntryQuantity(List<EntryData> entryData,
      {bool navigateHome = true,
      Function()? onSuccess,
      String? successMsg}) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );

    try {
      bool isSuccess = await HomeRepository().updateEntryQuantity(entryData);
      Get.back();
      if (isSuccess) {
        if (navigateHome) {
          Get.snackbar('Success', 'Data Added Successfully',
              duration: const Duration(seconds: 1));
          Future.delayed(const Duration(seconds: 2), () {
            AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
          });
        } else {
          Get.snackbar('Success', 'Ingredient deleted Successfully',
              duration: const Duration(seconds: 1));
          Future.delayed(const Duration(seconds: 2), () {
            print("remvoing screen");
            AppRouting().offAllNavigateTo(NameRoutes.homeScreen);
          });
        }
      }
    } catch (e) {
      Get.back();
    }
  }

  bool validateProductName(String name) {
    if (name.isEmpty) {
      Get.snackbar("Error", "Please select Product from List.");
      return false;
    }
    return true;
  }

  bool validateProductSubName(String name) {
    if (name.isEmpty) {
      Get.snackbar("Error", "Please enter subname for product.");
      return false;
    }
    return true;
  }

  // Function to validate quantity (must be a double)
  bool validateQuantity(double quantity) {
    if (quantity <= 0) {
      Get.snackbar("Error", "Please enter quantity for product.");
      return false;
    }
    return true;
  }

  // Function to validate quantity type
  bool validateQuantityType(String quantityType) {
    if (quantityType.isEmpty) {
      Get.snackbar("Error", "Please select quantity type for product.");
      return false;
    }
    return true;
  }

  // Function to validate all fields together
  bool validateProduct(ProductItemRequest product) {
    return validateProductName(productName.text) &&
        validateProductSubName(product.subname ?? '') &&
        validateQuantity(product.quantity) &&
        validateQuantityType(product.quantityType) &&
        validateExpiry();
  }

  validateExpiry() {
    if (isStandardExpiry.isFalse && expiryDate.value == null) {
      Get.snackbar("Error",
          "Please select standard expiry or select expiry date for product.");
      return false;
    }
    return true;
  }

  String getInventoryImage(String name) {
    switch (name.toLowerCase()) {
      case 'vegetable':
        return vegetables;
      case 'dairy':
        return dairy;
      case 'meat & fish':
        return meatFish;
      case 'grain':
        return grains;
      case 'bakery':
    return bakery;
  case 'baking ingredients':
    return bakingIngredients;
  case 'canned food':
    return cannedFood;
  case 'cereal':
    return cereal;
  case 'condiment':
    return condiment;
  case 'dessert':
    return dessert;
  case 'drink':
    return drink;
  case 'dry fruits':
    return dryFruits;
  case 'dry goods':
    return dryGoods;
  case 'frozen food':
    return frozenFood;
  case 'fruit':
    return fruit;
  case 'herbs':
    return herbs;
  case 'meat':
    return meat;
  case 'oil':
    return oil;
  case 'pasta':
    return pasta;
  case 'pickled items':
    return pickledItems;
  case 'ready-to-eat meals':
    return readyToEatMeals;
  case 'sauces':
    return sauces;
  case 'seafood':
    return seafood;
  case 'snacks':
    return snacks;
  case 'spices':
    return spices;
  case 'ingredients & spices':
    return spices;
      default:
        return categoryPlaceholder;
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
