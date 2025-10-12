import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/delete_entity.dart';
import '../entities/meal_with_types_entity.dart';

abstract class MealTypesRepository {
  Future<Either<Failure,List<MealWithTypesEntity>>> getTyperOfMeal(int meal_id);
  Future<Either<Failure,DeleteEntity>> deleteType({required int type_id});

}