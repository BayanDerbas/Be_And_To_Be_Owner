import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled/core/networks/failures.dart';
import 'package:untitled/features/categories/domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../data_sources/categories_service.dart';
import '../../domain/entities/add_category_entity.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesService service;

  CategoriesRepositoryImpl(this.service);

  @override
  Future<Either<Failure, AddCategoryEntity>> addMainCategory(
    String name,
    int branchId,
    dynamic pickedImage,
  ) async {
    try {
      MultipartFile multipart;

      if (kIsWeb) {
        final bytes = await pickedImage.readAsBytes();
        multipart = MultipartFile.fromBytes(bytes, filename: pickedImage.name);
      } else {
        multipart = await MultipartFile.fromFile(
          pickedImage.path,
          filename: pickedImage.name,
        );
      }

      final formData = FormData.fromMap({
        'name': name,
        'branch_id': branchId,
        'image': multipart,
      });

      final result = await service.addMainCategory(formData);

      return Right(AddCategoryEntity(message: result.message));
    } on DioException catch (e) {
      if (e.response != null &&
          e.response?.data != null &&
          e.response?.data['errors'] != null) {
        final errors = e.response?.data['errors'] as Map<String, dynamic>;
        final firstFieldErrors = errors.values.first as List;
        final message =
            firstFieldErrors.isNotEmpty
                ? firstFieldErrors.first.toString()
                : "Unknown error";
        return Left(Failure(message));
      }
      return Left(Failure("Something went wrong"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({required int branch_id}) async {
    try {
      final response = await service.getMainCategories(branch_id);
      final entity = response.allCategories.map((t) => t.toEntity()).toList();
      return Right(entity);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }
}
