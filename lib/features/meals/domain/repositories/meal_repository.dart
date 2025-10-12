import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/meals/domain/entities/add_meal_entity.dart';
import 'package:untitled/features/meals/domain/entities/delete_entity.dart';
import '../../../../core/networks/failures.dart';
import '../entities/meal_entity.dart';

abstract class MealRepository {
  Future<Either<Failure,List<MealEntity>>> getMealsOfCategory (int maincategory_id);
  Future<Either<Failure,DeleteEntity>> deleteMeal({required int meal_id});
  Future<Either<Failure,AddMealEntity>> addMeal({
    int? hasTypes,
    String mealname,
    String description,
    XFile image,
    int maincategory_id,
    int price,
    int extraprice,
    int textraprice,
    List<String>? tname,
    List <int>? tprice,
    List<int>? ttextraprice,
});
}