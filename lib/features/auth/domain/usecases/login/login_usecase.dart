import 'package:dartz/dartz.dart';

import '../../../../../core/networks/failures.dart';
import '../../entities/login/login_user_entity.dart';
import '../../repositories/login/login_repository.dart';

class LoginUseCase{
  final LoginRepository repository;

  LoginUseCase(this.repository);
  Future<Either<Failure,LoginUserEntity>> call ({
    required String phonenumber,
    required String password,
}) async {
    return await repository.login(phonenumber: phonenumber, password: password);
  }
}