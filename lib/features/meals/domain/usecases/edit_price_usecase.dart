import 'package:dartz/dartz.dart';
import 'package:untitled/features/meals/domain/entities/add_meal_entity.dart';
import '../../../../core/networks/failures.dart';
import '../repositories/get_types_of_meal_repository.dart';

class EditPriceUseCase {
  final MealTypesRepository repository;
  EditPriceUseCase(this.repository);
  Future<Either<Failure, AddMealEntity>> call(
    int type_id,
    int price,
    int extraprice,
  ) async {
    return repository.editPrice(type_id, price, extraprice);
  }
}
