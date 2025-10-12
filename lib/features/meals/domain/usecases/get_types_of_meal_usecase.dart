import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/meal_with_types_entity.dart';
import '../repositories/get_types_of_meal_repository.dart';

class GetTypesOfMealUseCase {
  final MealTypesRepository repository;

  GetTypesOfMealUseCase(this.repository);

  Future<Either<Failure, List<MealWithTypesEntity>>> call(int meal_id) async {
    return repository.getTyperOfMeal(meal_id);
  }
}