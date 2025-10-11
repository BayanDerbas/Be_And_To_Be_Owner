import 'package:equatable/equatable.dart';

class EditBranchNameEntity extends Equatable {
  final String message;

  EditBranchNameEntity({required this.message});

  @override
  List<Object?> get props => [message];
}