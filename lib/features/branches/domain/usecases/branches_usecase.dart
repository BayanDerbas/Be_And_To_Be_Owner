import 'package:dartz/dartz.dart';

import '../../../../core/networks/failures.dart';
import '../entities/branches_entity.dart';
import '../repositories/branches_repository.dart';

class BranchesUseCase{
  final BranchesRepository repository;

  BranchesUseCase(this.repository);

  Future<Either<Failure,BranchesEntity>> call (){
    return repository.getBranches();
  }
}