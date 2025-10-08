import 'package:dartz/dartz.dart';
import 'package:untitled/features/admins/data/data_sources/admin_service.dart';
import 'package:untitled/features/admins/domain/entities/add_admin_entity.dart';
import 'package:untitled/features/admins/domain/entities/admin_entity.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/repositories/admin_repository.dart';
import 'package:dio/dio.dart';
import '../models/admin_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminService service;

  AdminRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, List<AdminEntity>>> getAdmins() async {
    try {
      final AdminResponse response = await service.get_admins();
      final List<AdminEntity> admins = response.allInfo.map((model) => model.toEntity()).toList();
      return Right(admins);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, AddAdminEntity>> addAdmin({required String fullname, required String password, required String phonenumber, required int branch_id}) async {
    try {
      final response = await service.add_admin(fullname, password, phonenumber, branch_id);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
