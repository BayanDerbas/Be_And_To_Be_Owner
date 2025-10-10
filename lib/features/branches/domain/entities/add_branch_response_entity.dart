import 'package:equatable/equatable.dart';

class AddBranchResponseEntity extends Equatable {
  final String message;
  AddBranchResponseEntity({required this.message});

  @override
  List<Object?> get props => [message];
}