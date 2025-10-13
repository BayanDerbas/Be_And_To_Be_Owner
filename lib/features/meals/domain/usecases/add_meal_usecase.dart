import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/networks/failures.dart';
import '../entities/add_meal_entity.dart';
import '../repositories/meal_repository.dart';

class AddMealUseCase {
  final MealRepository repository;

  AddMealUseCase(this.repository);

  Future<Either<Failure, AddMealEntity>> call({
    int? hasTypes,
    required String mealName,
    required String description,
    required XFile image,
    required int mainCategoryId,
    required int price,
    int? extraPrice,
    int? tExtraPrice,
    List<String>? typeNames,
    List<int>? typePrices,
    List<int>? typeExtraPrices,
  }) async {
    return repository.addMeal(
      hasTypes: hasTypes,
      mealName: mealName,
      description: description,
      image: image,
      mainCategoryId: mainCategoryId,
      price: price,
      extraPrice: extraPrice,
      tExtraPrice: tExtraPrice,
      typeNames: typeNames,
      typePrices: typePrices,
      typeExtraPrices: typeExtraPrices,
    );
  }
}
