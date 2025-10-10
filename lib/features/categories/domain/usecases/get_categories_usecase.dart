import 'package:dartz/dartz.dart';
import 'package:untitled/core/networks/failures.dart';
import 'package:untitled/features/categories/domain/entities/category_entity.dart';
import 'package:untitled/features/categories/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure,List<CategoryEntity>>> call ({required int branch_id}) {
    return repository.getCategories(branch_id: branch_id);
  }
}