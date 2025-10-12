import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled/features/meals/data/models/add_meal_model.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/delete_model.dart';
import '../models/meals_response.dart';

part 'meal_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class MealService {
  factory MealService(Dio dio, {String baseUrl}) = _MealService;

  @GET('${ApiConstant.getMeals}/{maincategory_id}')
  Future<HttpResponse<MealsResponse>> getMealsOfCategory(@Path("maincategory_id") int maincategory_id,);

  @POST('${ApiConstant.deletemeal}/{meal_id}')
  Future<DeleteModel> deleteType(@Path("meal_id") int meal_id);

  @POST(ApiConstant.AddMeals)
  Future<AddMealModel> addMeal(@Body() FormData data);
}
