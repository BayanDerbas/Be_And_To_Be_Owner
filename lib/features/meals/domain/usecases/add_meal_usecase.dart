import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/core/networks/failures.dart';
import 'package:untitled/features/meals/domain/entities/add_meal_entity.dart';
import 'package:untitled/features/meals/domain/repositories/meal_repository.dart';

class AddMealUseCase{
  final MealRepository repository;
  AddMealUseCase(this.repository);
  Future<Either<Failure,AddMealEntity>> call({
    int? hasTypes,
    required String? mealname,
    required String? description,
    required XFile image,
    required int? maincategory_id,
    required int? price,
    int? extraprice,
    int? textraprice,
    List<String>? tname,
    List<int>? tprice,
    List<int>? ttextraprice,
}) async {
    return repository.addMeal(
      hasTypes: hasTypes,
      mealname: mealname ?? '',
      description: description ?? '',
      image: image,
      maincategory_id: maincategory_id ?? 0,
      price: price ?? 0,
      extraprice: extraprice ?? 0,
      textraprice: textraprice ?? 0,
      tname: tname,
      tprice: tprice,
      ttextraprice: ttextraprice,
    );
}
}