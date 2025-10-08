import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/add_admin_entity.dart';
import '../repositories/admin_repository.dart';

class AddAdminUseCase {
  final AdminRepository repository;

  AddAdminUseCase(this.repository);

  Future<Either<Failure, AddAdminEntity>> call({
    required String fullname,
    required String password,
    required String phonenumber,
    required int branch_id,
  }) async {
    return await repository.addAdmin(
      fullname: fullname,
      password: password,
      phonenumber: phonenumber,
      branch_id: branch_id,
    );
  }
}