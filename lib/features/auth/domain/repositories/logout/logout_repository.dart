import 'package:dartz/dartz.dart';
import '../../../../../core/networks/failures.dart';
import '../../entities/logout/logout_entity.dart';

abstract class LogoutRepository{
  Future<Either<Failure,LogoutEntity>> logout (String bearerToken);
}