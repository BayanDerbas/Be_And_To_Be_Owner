import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:untitled/features/meals/domain/entities/add_meal_entity.dart';
import 'package:untitled/features/meals/domain/usecases/edit_price_usecase.dart';

part 'edit_price_state.dart';

class EditPriceCubit extends Cubit<EditPriceState> {
  final EditPriceUseCase usecase;
  EditPriceCubit(this.usecase) : super(EditPriceInitial());

  Future<void> editPrice(int type_id, int price, int extraprice) async {
    final response = await usecase.call(type_id, price, extraprice);
    response.fold(
      (failure) => emit(EditPriceFailure(failure.message)),
      (entity) => emit(EditPriceSuccess(entity)),
    );
  }
}
