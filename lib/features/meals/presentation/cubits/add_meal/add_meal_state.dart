part of 'add_meal_cubit.dart';

abstract class AddMealState extends Equatable {
  const AddMealState();
  @override
  List<Object?> get props => [];
}

class AddMealInitial extends AddMealState {}

class AddMealLoading extends AddMealState {}

class AddMealSuccess extends AddMealState {
  final AddMealEntity meal;
  const AddMealSuccess(this.meal);
  @override
  List<Object?> get props => [meal.message];
}

class AddMealFailure extends AddMealState {
  final String message;
  const AddMealFailure(this.message);
  @override
  List<Object?> get props => [message];
}
