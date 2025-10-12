class ApiConstant {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String imageBase = "http://127.0.0.1:8000/";
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String refresh = "$baseUrl/auth/refresh";
  static const String get_admins = "$baseUrl/show_admins_withbranches";
  static const String add_main_categories = "$baseUrl/AddMainCategories";
  static const String add_admin = "$baseUrl/AddAdmin";
  static const String branch = "$baseUrl/show_branches";
  static const String getcategories = "$baseUrl/show_main_categories";
  static const String deletecategories = "$baseUrl/deletemaincategory";
  static const String addbranch = "$baseUrl/addbranch";
  static const String edit_branch_name = "$baseUrl/edit_branch_name";
  static const String getMeals = "$baseUrl/show_meals";
  static const String getTypesOfMeals = "$baseUrl/show_types";
}