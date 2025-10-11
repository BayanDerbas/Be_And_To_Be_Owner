import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/entities/edit_branch_name_entity.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/add_branch_response_entity.dart';
import '../../domain/entities/branches_entity.dart';
import '../../domain/repositories/branches_repository.dart';
import '../data_sources/branches_service.dart';

class BranchesRepositoryImpl implements BranchesRepository {
  final BranchesService service;
  BranchesRepositoryImpl(this.service);

  @override
  Future<Either<Failure, BranchesEntity>> getBranches() async {
    try {
      final result = await service.getBranches();
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddBranchResponseEntity>> addBranch({
    required String branch_name,
    required XFile image,
    required double length,
    required double width,
    String? facebooktoken,
    String? instagramtoken,
    required List<String> numbers,
  }) async {
    try {
      final formData = FormData();
      formData.fields.add(MapEntry('branch_name', branch_name));
      formData.fields.add(MapEntry('length', length.toString()));
      formData.fields.add(MapEntry('width', width.toString()));
      formData.fields.add(MapEntry('facebooktoken', facebooktoken ?? ''));
      formData.fields.add(MapEntry('instagramtoken', instagramtoken ?? ''));
      for (var phone in numbers) {
        formData.fields.add(MapEntry('phones[]', phone));
      }
      MultipartFile multipart;
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        multipart = MultipartFile.fromBytes(bytes, filename: image.name);
      } else {
        multipart = await MultipartFile.fromFile(image.path, filename: image.name);
      }
      formData.files.add(MapEntry('image', multipart));

      final response = await service.addBranch(formData);
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

  @override
  Future<Either<Failure, EditBranchNameEntity>> editBranch({required String new_name, required int branch_id}) async {
    try {
      final result = await service.edit_branch_name(new_name: new_name, branch_id: branch_id);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

}
