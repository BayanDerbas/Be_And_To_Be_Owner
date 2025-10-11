import 'package:dartz/dartz.dart';
import 'package:untitled/core/networks/failures.dart';
import 'package:untitled/features/branches/domain/entities/edit_branch_name_entity.dart';
import 'package:untitled/features/branches/domain/repositories/branches_repository.dart';

class EditBranchUseCase {
  final BranchesRepository repository;
  EditBranchUseCase(this.repository);
  Future<Either<Failure,EditBranchNameEntity>> call({
    required String new_name,
    required int branch_id,
}) async {
    return repository.editBranch(new_name: new_name, branch_id: branch_id);
}
}