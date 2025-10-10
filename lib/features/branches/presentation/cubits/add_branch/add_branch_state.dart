part of 'add_branch_cubit.dart';

abstract class AddBranchState extends Equatable {
  const AddBranchState();

  @override
  List<Object?> get props => [];
}

class AddBranchInitial extends AddBranchState {}

class AddBranchLoading extends AddBranchState {}

class AddBranchSuccess extends AddBranchState {
  final String message;
  const AddBranchSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddBranchFailure extends AddBranchState {
  final String error;
  const AddBranchFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
