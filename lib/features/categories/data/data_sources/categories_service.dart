import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled/features/categories/data/models/delete_category/delete_main_category.dart';
import '../models/add_categories/add_category_response.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/get_categories/main_category_model.dart';

part 'categories_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class CategoriesService {
  factory CategoriesService(Dio dio, {String? baseUrl}) = _CategoriesService;

  @POST(ApiConstant.add_main_categories)
  Future<AddCategoryResponse> addMainCategory(@Body() FormData data);

  @GET('${ApiConstant.getcategories}/{branch_id}')
  Future<MainCategoriesResponse> getMainCategories(
      @Path("branch_id") int branchId,
      );
  @POST('${ApiConstant.deletecategories}/{main_category_id}')
  Future<DeleteMainCategory> deleteMainCategories(
      @Path("main_category_id") int main_category_id,
      );
}

