import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/meal_with_types_entity.dart';
import '../../../domain/usecases/get_types_of_meal_usecase.dart';

part 'meal_types_state.dart';

class MealTypesCubit extends Cubit<MealTypesState> {
  final GetTypesOfMealUseCase useCase;
  MealTypesCubit(this.useCase) : super(MealTypesInitial());
  int? _currentMealId;

  Future<void> getMealsTypes(int mealId) async {
    _currentMealId = mealId;
    emit(MealTypesLoading());
    final result = await useCase(mealId);
    result.fold(
      (failure) {
        debugPrint("❌ MealTypesCubit Error: ${failure.message}");
        emit(MealTypesFailure(message: failure.message));
      },
      (meals) {
        debugPrint("✅ MealTypesCubit Success: meals loaded for mealId $mealId");
        emit(MealTypesSuccess(meals));
      },
    );
  }
}
