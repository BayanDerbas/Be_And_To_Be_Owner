import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class GetMealOfCategoryUseCase {
  final MealRepository repository;

  GetMealOfCategoryUseCase(this.repository);
  Future<Either<Failure,List<MealEntity>>> call(int maincategory_id) {
    return repository.getMealsOfCategory(maincategory_id);
  }
}