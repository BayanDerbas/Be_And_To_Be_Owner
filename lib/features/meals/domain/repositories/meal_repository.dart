import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/meal_entity.dart';

abstract class MealRepository {
  Future<Either<Failure,List<MealEntity>>> getMealsOfCategory (int maincategory_id);
}