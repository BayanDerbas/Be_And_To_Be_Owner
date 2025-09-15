import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/add_categories/add_category_response.dart';
import '../../../../core/networks/api_constant.dart';

part 'categories_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class CategoriesService {
  factory CategoriesService(Dio dio, {String? baseUrl}) = _CategoriesService;

  @POST(ApiConstant.add_main_categories)
  Future<AddCategoryResponse> addMainCategory(@Body() FormData data);
}

