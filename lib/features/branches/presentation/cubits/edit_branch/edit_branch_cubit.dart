import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/features/branches/domain/entities/edit_branch_name_entity.dart';
import 'package:untitled/features/branches/domain/usecases/edit_branch_usecase.dart';

part 'edit_branch_state.dart';

class EditBranchCubit extends Cubit<EditBranchState> {
  final EditBranchUseCase usecase;
  EditBranchCubit(this.usecase) : super(EditBranchInitial());

  Future<void> edit_branch({
    required String new_name,
    required int branch_id,
}) async {
    final response = await usecase.call(new_name: new_name, branch_id: branch_id);
    response.fold(
            (failure){
              emit(EditBranchFailure(failure.message));
            },
            (entity){
              emit(EditBranchSuccess(entity));
            }
    );
  }
}
