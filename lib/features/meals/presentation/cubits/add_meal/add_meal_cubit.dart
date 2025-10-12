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
    int? hasTypes,
    required String mealname,
    required String description,
    required dynamic image,
    required int maincategory_id,
    required int price,
    int? extraprice,
    int? textraprice,
    List<String>? tname,
    List<int>? tprice,
    List<int>? ttextraprice,
  }) async {
    emit(AddMealLoading());
    final result = await addMealUseCase.call(
      hasTypes: hasTypes,
      mealname: mealname,
      description: description,
      image: image,
      maincategory_id: maincategory_id,
      price: price,
      extraprice: extraprice,
      textraprice: textraprice,
      tname: tname,
      tprice: tprice,
      ttextraprice: ttextraprice,
    );

    result.fold(
          (failure) => emit(AddMealFailure(failure.message)),
          (meal) => emit(AddMealSuccess(meal)),
    );
  }
}