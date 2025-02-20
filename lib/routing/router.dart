import 'package:fridge_app/features/cuisine_category/cuisine_category_screen.dart';
import 'package:fridge_app/features/cuisine_category/cuisine_recipe_screen.dart';
import 'package:fridge_app/features/cuisine_category/cuisine_screen.dart';
import 'package:fridge_app/features/cuisine_category/fridge_ingredient_screen.dart';
import 'package:fridge_app/features/cuisine_category/update_ingredient_screen.dart';
import 'package:fridge_app/features/grocery/grocery_detail_screen.dart';
import 'package:fridge_app/features/grocery/grocery_screen.dart';
import 'package:fridge_app/features/home/add_item_screen.dart';
import 'package:fridge_app/features/home/home_screen.dart';
import 'package:fridge_app/features/login/login_screen.dart';
import 'package:fridge_app/features/sign_up/sign_up_screen.dart';
import 'package:fridge_app/features/splash/splash_screen.dart';
import 'package:fridge_app/routing/name_routes.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routingData = [
  GetPage(
    name: NameRoutes.splashScreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: NameRoutes.loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: NameRoutes.signupScreen,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: NameRoutes.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: NameRoutes.addItemScreen,
    page: () => const AddItemScreen(),
  ),
  GetPage(
    name: NameRoutes.groceryScreen,
    page: () => const GroceryScreen(),
  ),
  GetPage(
    name: NameRoutes.groceryDetailsScreen,
    page: () => const GroceryDetailsScreen(),
  ),
  GetPage(
    name: NameRoutes.cuisineCategoryScreen,
    page: () => const CuisineCategoryScreen(),
  ),
  GetPage(
    name: NameRoutes.cuisineScreen,
    page: () => const CuisineScreen(),
  ),
  GetPage(
    name: NameRoutes.cuisineRecipeScreen,
    page: () => const CuisineRecipeScreen(),
  ),
  GetPage(
    name: NameRoutes.fridgeIngredientScreen,
    page: () => const FridgeIngredientScreen(),
  ),
  GetPage(
    name: NameRoutes.updateIngredientScreen,
    page: () => const UpdateIngredientScreen(),
  )
];

class AppRouting {
  void routeTo(String page,
      {
      dynamic arguments,
      Transition? transition,
      Function? onPopCallback}) {
    Get.toNamed(page, arguments: arguments, )?.then((value){
       if(onPopCallback != null) onPopCallback(value);
    });
  }

  void offAndNavigateTo(String page,
      {
      dynamic arguments,
      Transition? transition,
      Function? onPopCallback}) {
    Get.offAndToNamed(page, arguments: arguments, )?.then((value){
       if(onPopCallback != null) onPopCallback();
    });
  }

  void offAllNavigateTo(String page,
      {
      dynamic arguments,
      Transition? transition,
      Function? onPopCallback}) {
    Get.offAllNamed(page, arguments: arguments, )?.then((value){
       if(onPopCallback != null) onPopCallback();
    });
  }
}
