import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/entities/add_branch_response_entity.dart';
import '../../../../core/networks/failures.dart';
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
    required double? length,
    required double? width,
    String? facebooktoken,
    String? instagramtoken,
    required List<String> numbers,
  }) async {
    try {
      MultipartFile multipart;

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        multipart = MultipartFile.fromBytes(bytes, filename: image.name);
      } else {
        multipart = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap({
        'branch_name': branch_name,
        'image': multipart,
        'length': length,
        'width': width,
        'facebooktoken': facebooktoken,
        'instagramtoken': instagramtoken,
        ...Map.fromEntries(numbers.map((e) => MapEntry('phones[]', e))),
      });

      final response = await service.addBranch(data: formData);
      return Right(response);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }
}