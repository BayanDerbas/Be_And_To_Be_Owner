import 'package:dartz/dartz.dart';
import 'package:untitled/features/meals/domain/repositories/get_types_of_meal_repository.dart';
import '../../../../core/networks/failures.dart';
import '../entities/delete_entity.dart';

class DeleteTypeUseCase {
  final MealTypesRepository repository;
  DeleteTypeUseCase(this.repository);
  Future<Either<Failure,DeleteEntity>> call(int type_id) {
    return repository.deleteType(type_id: type_id);
  }
}