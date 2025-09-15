import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/branch_entity.dart';
import '../../../domain/entities/branches_entity.dart';
import '../../../domain/usecases/branches_usecase.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchesUseCase useCase;

  BranchCubit(this.useCase) : super(BranchInitial());

  List<BranchEntity> branches = [];
  BranchEntity? selectedBranch;

  Future<void> fetchBranches() async {
    emit(BranchLoading());
    final result = await useCase();
    result.fold(
          (failure) => emit(BranchesFailure(failure.message)),
          (branchesEntity) {
        branches = branchesEntity.branches;
        emit(BranchSuccess(branchesEntity));
      },
    );
  }

  void selectBranch(BranchEntity branch) {
    selectedBranch = branch;
    emit(BranchSelected(branch));
  }
}
