import 'package:dartz/dartz.dart';
import 'package:untitled/features/meals/domain/entities/delete_entity.dart';
import 'package:untitled/features/meals/domain/repositories/meal_repository.dart';
import '../../../../core/networks/failures.dart';

class DeleteMealUseCase {
  final MealRepository repository;

  DeleteMealUseCase(this.repository);
  Future<Either<Failure,DeleteEntity>> call(int meal_id) {
    return repository.deleteMeal(meal_id: meal_id);
  }
}