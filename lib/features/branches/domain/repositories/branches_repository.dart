import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/branches_entity.dart';

abstract class BranchesRepository{
  Future <Either<Failure,BranchesEntity>> getBranches ();
}