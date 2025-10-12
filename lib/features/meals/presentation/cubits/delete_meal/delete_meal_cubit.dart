import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/features/meals/domain/entities/delete_entity.dart';
import 'package:untitled/features/meals/domain/usecases/delete_meal_usecase.dart';

part 'delete_meal_state.dart';

class DeleteMealCubit extends Cubit<DeleteMealState> {
  final DeleteMealUseCase usecase;
  DeleteMealCubit(this.usecase) : super(DeleteMealInitial());

  Future<void> deleteMeal(int meal_id) async {
    emit(DeleteMealLoading());
    final response = await usecase.call(meal_id);
    response.fold(
          (failure) {
        emit(DeleteMealFailure(failure.message));
      },
          (message) {
        emit(DeleteMealSuccess(message));
      },
    );
  }
}


