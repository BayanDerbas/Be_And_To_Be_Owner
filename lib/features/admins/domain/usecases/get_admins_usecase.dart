import 'package:dartz/dartz.dart';
import 'package:untitled/features/admins/data/models/admin_model.dart';
import '../../../../core/networks/failures.dart';
import '../entities/admin_entity.dart';
import '../repositories/admin_repository.dart';

class GetAdminsUseCase {
  final AdminRepository repository;

  GetAdminsUseCase(this.repository);

  Future<Either<Failure, List<AdminEntity>>> call() {
    return repository.getAdmins();
  }
}
