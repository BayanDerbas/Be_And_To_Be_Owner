import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/core/networks/failures.dart';
import 'package:untitled/features/categories/domain/entities/add_category_entity.dart';
import 'package:untitled/features/categories/domain/repositories/categories_repository.dart';

class AddMainCategotryUseCase {
  final CategoriesRepository repository;

  AddMainCategotryUseCase(this.repository);
  Future<Either<Failure,AddCategoryEntity>> call(String name,int branch_id,XFile image) {
    return repository.addMainCategory(name, branch_id, image);
  }
}