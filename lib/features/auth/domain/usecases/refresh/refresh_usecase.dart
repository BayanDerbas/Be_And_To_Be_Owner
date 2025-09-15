import 'package:dartz/dartz.dart';
import '../../../../../core/networks/failures.dart';
import '../../entities/refresh/refresh_entity.dart';
import '../../repositories/refresh/refresh_repository.dart';

class RefreshUseCase{
  final RefreshRepository repository;

  RefreshUseCase(this.repository);
  Future <Either<Failure,RefreshEntity>> call(String bearerToken) async {
    return await repository.refresh(bearerToken);
  }
}