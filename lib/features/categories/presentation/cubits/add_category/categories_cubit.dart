import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/categories/domain/usecases/add_main_category_usecase.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final AddMainCategotryUseCase addMainCategotryUseCase;
  CategoriesCubit(this.addMainCategotryUseCase) : super(CategoriesInitial());

  final List<Map<String, dynamic>> _categories = [];

  List<Map<String, dynamic>> get categories => List.unmodifiable(_categories);

  Future<void> addCategory(String name, int branchId, XFile pickedImage) async {
    emit(CategoriesLoading());

    final imagePath = pickedImage.path;

    final result = await addMainCategotryUseCase(name, branchId, pickedImage);

    result.fold(
          (failure) => emit(CategoriesFailure(failure.message.toString())),
          (entity) {
        _categories.add({
          'name': name,
          'branch_id': branchId,
          'image': imagePath,
        });
        emit(CategoriesSuccess(List.from(_categories)));
      },
    );
  }
}
