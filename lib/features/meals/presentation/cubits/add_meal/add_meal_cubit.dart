import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/add_meal_entity.dart';
import '../../../domain/usecases/add_meal_usecase.dart';

part 'add_meal_state.dart';

class AddMealCubit extends Cubit<AddMealState> {
  final AddMealUseCase addMealUseCase;

  AddMealCubit(this.addMealUseCase) : super(AddMealInitial());

  Future<void> addMeal({
    required String mealName,
    required String description,
    required dynamic image,
    required int mainCategoryId,
    required int price,
    int? extraPrice,
    int? tExtraPrice,
    int? hasTypes,
    List<String>? typeNames,
    List<int>? typePrices,
    List<int>? typeExtraPrices,
  }) async {
    emit(AddMealLoading());
    final result = await addMealUseCase.call(
      hasTypes: hasTypes,
      mealName: mealName,
      description: description,
      image: image,
      mainCategoryId: mainCategoryId,
      price: price,
      extraPrice: extraPrice,
      tExtraPrice: tExtraPrice,
      typeNames: typeNames,
      typePrices: typePrices,
      typeExtraPrices: typeExtraPrices,
    );

    result.fold(
          (failure) {
            emit(AddMealFailure(failure.message));
            },
          (meal) => emit(AddMealSuccess(meal)),
    );
  }
}