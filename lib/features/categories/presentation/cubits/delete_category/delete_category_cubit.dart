import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:untitled/features/categories/domain/entities/delete_main_category_entity.dart';
import 'package:untitled/features/categories/domain/usecases/delete_main_category_usecase.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  final DeleteMainCategotryUseCase usecase;
  DeleteCategoryCubit(this.usecase) : super(DeleteCategoryInitial());

  Future<void> deleteCategory(int main_category_id) async {
    emit(DeleteCategoryLoading());
    final response = await usecase.call(main_category_id);
    response.fold(
          (failure) {
        emit(DeleteCategoryFailure(failure.message));
      },
          (entity) {
        emit(DeleteCategorySuccess(entity));
      },
    );
  }
}


