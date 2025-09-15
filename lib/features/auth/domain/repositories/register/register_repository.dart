import 'package:dartz/dartz.dart';
import '../../../../../core/networks/failures.dart';
import '../../entities/register/register_user.dart';

abstract class RegisterRepository{
  Future<Either<Failure,RegisterUserEntity>> register({
    required String fullname,
    required String phonenumber,
    required String password,
});
}