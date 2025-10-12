import 'package:equatable/equatable.dart';

class DeleteEntity extends Equatable {
  final String message;
  DeleteEntity(this.message);
  @override
  List<Object?> get props => [message];

}