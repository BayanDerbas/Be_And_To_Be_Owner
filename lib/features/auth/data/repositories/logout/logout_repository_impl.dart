import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/networks/failures.dart';
import '../../../domain/entities/logout/logout_entity.dart';
import '../../../domain/repositories/logout/logout_repository.dart';
import '../../data_sources/logout/logout_service.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutService logoutService;

  LogoutRepositoryImpl(this.logoutService);
  @override
  Future<Either<Failure, LogoutEntity>> logout(String bearerToken) async {
    try{
      final result = await logoutService.logout(bearerToken);
      return Right(result);
    }
    on DioException catch(e){
      return Left(Failure.fromDioError(e));
    }
    catch(e){
      return Left(Failure('Unexpected error: $e'));
    }
  }
}