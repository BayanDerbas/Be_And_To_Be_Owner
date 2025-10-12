part of 'get_categories_cubit.dart';

abstract class GetCategoriesState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesLoading extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<CategoryEntity> categories;
  GetCategoriesSuccess({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class GetCategoriesFailure extends GetCategoriesState {
  final String message;
  GetCategoriesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CategorySelected extends GetCategoriesState {
  final CategoryEntity category;
  CategorySelected(this.category);
  @override
  List<Object?> get props => [category];
}