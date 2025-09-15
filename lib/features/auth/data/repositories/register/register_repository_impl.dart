import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/networks/failures.dart';
import '../../../domain/entities/register/register_user.dart';
import '../../../domain/repositories/register/register_repository.dart';
import '../../data_sources/register/register_service.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService service;

  RegisterRepositoryImpl(this.service);
  @override
  Future<Either<Failure, RegisterUserEntity>> register({
    required String fullname,
    required String phonenumber,
    required String password,
  }) async {
    try{
      final response = await service.register(fullname: fullname, phonenumber: phonenumber, password: password);
      return Right(response);
    } on DioException catch(e){
      print("Exception Error : ${e}");
      return Left(Failure.fromDioError(e));
    }
    catch (e){
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
