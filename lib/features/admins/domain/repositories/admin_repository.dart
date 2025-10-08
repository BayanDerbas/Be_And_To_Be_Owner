import 'package:dartz/dartz.dart';
import 'package:untitled/features/admins/domain/entities/add_admin_entity.dart';
import 'package:untitled/features/admins/domain/entities/admin_entity.dart';
import '../../../../core/networks/failures.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<AdminEntity>>> getAdmins();
  Future<Either<Failure,AddAdminEntity>> addAdmin({
    required String fullname,
    required String password,
    required String phonenumber,
    required int branch_id,
});
}
