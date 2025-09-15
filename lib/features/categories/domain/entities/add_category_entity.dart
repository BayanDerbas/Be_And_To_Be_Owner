import 'package:equatable/equatable.dart';

class AddCategoryEntity extends Equatable {
  final String message;

  AddCategoryEntity({required this.message});
  @override
  List<Object?> get props => [message];
}