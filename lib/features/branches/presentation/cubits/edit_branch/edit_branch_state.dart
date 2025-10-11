part of 'edit_branch_cubit.dart';

abstract class EditBranchState extends Equatable {
  @override
  List<Object?> get props => [];
}

 class EditBranchInitial extends EditBranchState {}
 class EditBranchLoading extends EditBranchState {}
class EditBranchSuccess extends EditBranchState {
  final EditBranchNameEntity entity;
  EditBranchSuccess(this.entity);
  @override
  List<Object?> get props => [entity.message];
}
class EditBranchFailure extends EditBranchState {
  final String message;
  EditBranchFailure(this.message);
  @override
  List<Object?> get props => [message];
}

