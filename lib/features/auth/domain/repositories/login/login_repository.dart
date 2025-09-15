import 'package:dartz/dartz.dart';
import '../../../../../core/networks/failures.dart';
import '../../entities/login/login_user_entity.dart';

abstract class LoginRepository{
  Future<Either<Failure,LoginUserEntity>> login ({
    required String phonenumber,
    required String password,
});
}