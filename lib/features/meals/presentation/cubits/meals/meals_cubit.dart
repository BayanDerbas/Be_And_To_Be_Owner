import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/meal_entity.dart';
import '../../../domain/usecases/get_meals_of_category_usecase.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final GetMealOfCategoryUseCase getMealsUseCase;

  MealsCubit(this.getMealsUseCase) : super(MealsInitial());

  Future<void> fetchMeals(int category_id) async {
    emit(MealsLoading());
    final result = await getMealsUseCase(category_id);
    result.fold(
          (failure) => emit(MealsFailure(failure.message)),
          (meals) => emit(MealsSuccess(meals)),
    );
  }
}
