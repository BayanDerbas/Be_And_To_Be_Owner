import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/features/categories/domain/usecases/get_categories_usecase.dart';
import '../../../domain/entities/category_entity.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final GetCategoriesUseCase useCase;
  CategoryEntity? selectedCategory;
  List<CategoryEntity> categories = [];

  GetCategoriesCubit(this.useCase) : super(GetCategoriesInitial());
  Future<void> fetchCategories(int branchId) async {
    emit(GetCategoriesLoading());
    final result = await useCase.call(branch_id: branchId);
    result.fold(
          (failure) => emit(GetCategoriesFailure(message: failure.message)),
          (categoriesList) {
        categories = categoriesList;
        selectedCategory = null;
        emit(GetCategoriesSuccess(categories: categoriesList));
      },    );
  }
  void selectaCategory(CategoryEntity? category) {
    selectedCategory = category;
    emit(CategorySelected(category!));
  }
}
