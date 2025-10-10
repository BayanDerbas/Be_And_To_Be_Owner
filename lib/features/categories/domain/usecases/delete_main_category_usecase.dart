import 'package:dartz/dartz.dart';
import 'package:untitled/features/categories/domain/entities/delete_main_category_entity.dart';
import '../../../../core/networks/failures.dart';
import '../repositories/categories_repository.dart';

class DeleteMainCategotryUseCase {
  final CategoriesRepository repository;

  DeleteMainCategotryUseCase(this.repository);
  Future<Either<Failure,DeleteMainCategoryEntity>> call(int main_category_id) {
    return repository.deleteMainCategory(main_category_id: main_category_id);
  }
}