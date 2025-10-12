import 'package:equatable/equatable.dart';

class AddMealEntity extends Equatable {
  final String message;
  AddMealEntity(this.message);
  @override
  List<Object?> get props => [message];
}