import 'package:equatable/equatable.dart';

class AddAdminEntity extends Equatable {
  final String message;
  AddAdminEntity({required this.message});
  @override
  List<Object?> get props => [message];
}