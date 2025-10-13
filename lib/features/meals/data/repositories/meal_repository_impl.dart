import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/meals/domain/entities/add_meal_entity.dart';
import 'package:untitled/features/meals/domain/entities/delete_entity.dart';
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

  @override
  Future<Either<Failure, DeleteEntity>> deleteMeal({required int meal_id})async {
    try {
      final response = await service.deleteType(meal_id);
      return Right(response);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, AddMealEntity>> addMeal({
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
    try {
      final formData = FormData();

      // 🔹 Basic fields
      formData.fields.add(MapEntry('hastypes', hasTypes?.toString() ?? '0'));
      formData.fields.add(MapEntry('mealname', mealName));
      formData.fields.add(MapEntry('description', description));
      formData.fields.add(MapEntry('maincategory_id', mainCategoryId.toString()));
      formData.fields.add(MapEntry('price', price.toString()));
      formData.fields.add(MapEntry('extraprice', extraPrice?.toString() ?? '0'));

      // 🔹 Single textraprice (not array)
      if (tExtraPrice != null) {
        formData.fields.add(MapEntry('textraprice', tExtraPrice.toString()));
      }

      // 🔹 Arrays for types
      if (typeNames != null) {
        for (var name in typeNames) {
          formData.fields.add(MapEntry('tname[]', name));
        }
      }

      if (typePrices != null) {
        for (var p in typePrices) {
          formData.fields.add(MapEntry('tprice[]', p.toString()));
        }
      }

      if (typeExtraPrices != null) {
        for (var tp in typeExtraPrices) {
          formData.fields.add(MapEntry('textraprice[]', tp.toString()));
        }
      }

      MultipartFile multipart;
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        multipart = MultipartFile.fromBytes(bytes, filename: image.name);
      } else {
        multipart = await MultipartFile.fromFile(image.path, filename: image.name);
      }
      formData.files.add(MapEntry('image', multipart));

      final response = await service.addMeal(formData);
      return Right(response);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['errors'] != null) {
        final errors = e.response!.data['errors'] as Map<String, dynamic>;
        final firstError = errors.values.first as List;
        return Left(Failure(firstError.first.toString()));
      }
      return Left(Failure("Something went wrong"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, AddMealEntity>> addMeal({
  //   int? hasTypes,
  //   required String mealName,
  //   required String description,
  //   required XFile image,
  //   required int mainCategoryId,
  //   required int price,
  //   int? extraPrice,
  //   int? tExtraPrice,
  //   List<String>? typeNames,
  //   List<int>? typePrices,
  //   List<int>? typeExtraPrices,
  // }) async {
  //   try {
  //     final formData = FormData();
  //
  //     formData.fields.add(MapEntry('hastypes', hasTypes?.toString() ?? '0'));
  //     formData.fields.add(MapEntry('mealname', mealName));
  //     formData.fields.add(MapEntry('description', description));
  //     formData.fields.add(MapEntry('maincategory_id', mainCategoryId.toString()));
  //     formData.fields.add(MapEntry('price', price.toString()));
  //     formData.fields.add(MapEntry('extraprice', extraPrice?.toString() ?? '0'));
  //     formData.fields.add(MapEntry('textraprice', tExtraPrice?.toString() ?? '0'));
  //
  //     if (typeNames != null) {
  //       for (var name in typeNames) {
  //         formData.fields.add(MapEntry('tname[]', name));
  //       }
  //     }
  //
  //     if (typePrices != null) {
  //       for (var p in typePrices) {
  //         formData.fields.add(MapEntry('tprice[]', p.toString()));
  //       }
  //     }
  //
  //     if (typeExtraPrices != null) {
  //       for (var tp in typeExtraPrices) {
  //         formData.fields.add(MapEntry('ttextraprice[]', tp.toString()));
  //       }
  //     }
  //
  //     MultipartFile multipart;
  //     if (kIsWeb) {
  //       final bytes = await image.readAsBytes();
  //       multipart = MultipartFile.fromBytes(bytes, filename: image.name);
  //     } else {
  //       multipart = await MultipartFile.fromFile(image.path, filename: image.name);
  //     }
  //     formData.files.add(MapEntry('image', multipart));
  //
  //     final response = await service.addMeal(formData);
  //     return Right(response);
  //
  //   } on DioException catch (e) {
  //     if (e.response?.data != null && e.response?.data['errors'] != null) {
  //       final errors = e.response!.data['errors'] as Map<String, dynamic>;
  //       final firstError = errors.values.first as List;
  //       return Left(Failure(firstError.first.toString()));
  //     }
  //     return Left(Failure("Something went wrong"));
  //   } catch (e) {
  //     return Left(Failure(e.toString()));
  //   }
  // }
}