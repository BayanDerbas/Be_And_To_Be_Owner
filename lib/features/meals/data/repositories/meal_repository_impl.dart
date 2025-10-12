import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';
import '../data_sources/meal_service.dart';

class MealRepositoryImpl implements MealRepository {
  final MealService service;

  MealRepositoryImpl(this.service);
  @override
  Future<Either<Failure, List<MealEntity>>> getMealsOfCategory(int maincategory_id) async {
    try {
      final result = await service.getMealsOfCategory(maincategory_id);
      return Right(result.data.meals);
    } on DioException catch (dioErr) {
      return Left(Failure.fromDioError(dioErr));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}