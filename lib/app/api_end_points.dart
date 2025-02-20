class ApiEndPointUrls {
  // Micro Services
  static const String apiBaseUrl = "http://3.89.18.62:8000/";
  static const String loginUrl = "auth/login"; // login
  static const String updateUrl = "user/update"; 
  static const String registerUserUrl = "auth/register-user"; // sign up
  static const String homeUrl = "core/home"; // category list
  static const String addProductUrl = "user/addProduct"; // add product
  static const String searchUrl = "user/get-product-list"; // search product
  static const String expiryNotificationUrl = "core/expiry"; 
  static const String profileInfoUrl = "auth/profile"; 
  static const String updateQuantityUrl = "core/update-quantity";
  static const String cuisineListUrl = "core/list-cuisine-wishlist";
  static const String cuisineRecipeListUrl = "core/list-recipes";
  static const String cuisineRecipeDetailUrl = "core/detail-recipes";
  static const String productWishListUrl = "core/list-favs";
  static const String addProductWishListUrl = "core/add-favs";
  static const String removeProductWishListUrl = "core/remove-favs";
  static const String dropdownDataUrl = "core/dropdown-data";
  static const String getIngredientsUrl = "core/get-ingredients";
  static const String letsCookUrl = "core/lets-cook";
}