import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/meal_with_types_entity.dart';
import '../../domain/repositories/get_types_of_meal_repository.dart';
import '../data_sources/meal_types_service.dart';
import '../models/meal_with_types_model.dart';

class MealTypesRepositoryImpl implements MealTypesRepository {
  final MealTypesService service;

  MealTypesRepositoryImpl(this.service);

  @override
  Future<Either<Failure, List<MealWithTypesEntity>>> getTyperOfMeal(int meal_id) async {
    try {
      final response = await service.getTypesOfMeal(meal_id);
      final data = response.data["meals with types"] as List;
      final normalized = data.map((raw) {
        final map = Map<String, dynamic>.from(raw as Map);
        if (map.containsKey('type') && !map.containsKey('types')) {
          map['types'] = map['type'];
        }
        return map;
      }).toList();
      final meals = normalized.map((e) => MealWithTypeModel.fromJson(e)).toList();


      print("✅ [MealTypesRepository] Parsed meals: $meals");

      return Right(meals);
    } catch (e, st) {
      print("❌ [MealTypesRepository] Error: $e\n📌 Stacktrace: $st");
      return Left(Failure(e.toString()));
    }
  }
}
