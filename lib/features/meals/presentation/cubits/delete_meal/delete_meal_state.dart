part of 'delete_meal_cubit.dart';

abstract class DeleteMealState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteMealInitial extends DeleteMealState {}

class DeleteMealLoading extends DeleteMealState {}

class DeleteMealSuccess extends DeleteMealState {
  final DeleteEntity message;
  DeleteMealSuccess(this.message);
  @override
  List<Object?> get props => [message.message];
}

class DeleteMealFailure extends DeleteMealState {
  final String message;
  DeleteMealFailure(this.message);
  @override
  List<Object?> get props => [message];
}
