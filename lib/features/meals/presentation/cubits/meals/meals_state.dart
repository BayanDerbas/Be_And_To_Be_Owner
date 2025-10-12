part of 'meals_cubit.dart';

abstract class MealsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsSuccess extends MealsState {
  final List<MealEntity> meals;
  MealsSuccess(this.meals);

  @override
  List<Object?> get props => [meals];
}

class MealsFailure extends MealsState {
  final String message;
  MealsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
