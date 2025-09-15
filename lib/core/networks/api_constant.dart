class ApiConstant {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String imageBase = "http://127.0.0.1:8000/";
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String refresh = "$baseUrl/auth/refresh";
  //add main catogries
  static const String add_main_categories = "$baseUrl/AddMainCategories";

  static const String add_admin = "$baseUrl/AddAdmin";
  static const String branch = "$baseUrl/show_branches";
  static const String categories = "$baseUrl//getmaincategories/1";
  static const String request = "$baseUrl/getmaincategories";
  static const String getMeals = "$baseUrl/getmealsofcategory";
  static const String getTypesOfMeals = "$baseUrl/gettypesofmeal";
}