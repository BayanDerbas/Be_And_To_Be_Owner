import 'package:dartz/dartz.dart';
import '../../../../../core/networks/failures.dart';
import '../../entities/refresh/refresh_entity.dart';

abstract class RefreshRepository {
  Future<Either<Failure,RefreshEntity>> refresh (String bearerToken);
}