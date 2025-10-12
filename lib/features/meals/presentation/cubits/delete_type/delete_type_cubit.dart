import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/features/meals/domain/usecases/delete_type_usecase.dart';
import '../../../domain/entities/delete_entity.dart';

part 'delete_type_state.dart';

class DeleteTypeCubit extends Cubit<DeleteTypeState> {
  final DeleteTypeUseCase usecase;
  DeleteTypeCubit(this.usecase) : super(DeleteTypeInitial());

  Future<void> deleteType(int main_Type_id) async {
    emit(DeleteTypeLoading());
    final response = await usecase.call(main_Type_id);
    response.fold(
          (failure) {
        emit(DeleteTypeFailure(failure.message));
      },
          (entity) {
        emit(DeleteTypeSuccess(entity));
      },
    );
  }
}


