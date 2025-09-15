import 'package:dartz/dartz.dart';
import '../../../../../core/networks/failures.dart';
import '../../entities/logout/logout_entity.dart';
import '../../repositories/logout/logout_repository.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase(this.repository);
   Future<Either<Failure,LogoutEntity>> call (String bearerToken) async {
     return await repository.logout(bearerToken);
   }
}