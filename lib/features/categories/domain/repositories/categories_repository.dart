import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/core/networks/failures.dart';
import 'package:untitled/features/categories/domain/entities/add_category_entity.dart';
import 'package:untitled/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, AddCategoryEntity>> addMainCategory(
    String name,
    int branch_id,
    XFile image,
  );
  Future<Either<Failure,List<CategoryEntity>>> getCategories({
    required int branch_id,
});
}
