import 'package:dartz/dartz.dart';
import 'package:untitled/features/admins/domain/entities/admin_entity.dart';
import '../../../../core/networks/failures.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<AdminEntity>>> getAdmins();
}
