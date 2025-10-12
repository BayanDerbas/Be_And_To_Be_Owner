import 'package:equatable/equatable.dart';

class MealStatusEntity extends Equatable {
  final String message;

  MealStatusEntity({required this.message});

  @override
  List<Object?> get props => [message];
}