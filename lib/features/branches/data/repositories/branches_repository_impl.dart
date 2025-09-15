import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/branches_entity.dart';
import '../../domain/repositories/branches_repository.dart';
import '../data_sources/branches_service.dart';

class BranchesRepositoryImpl implements BranchesRepository{
  final BranchesService service;
  BranchesRepositoryImpl(this.service);
  @override
  Future<Either<Failure, BranchesEntity>> getBranches() async {
    try{
      final result = await service.getBranches();
      return Right(result);
    }on DioException catch (e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }
}