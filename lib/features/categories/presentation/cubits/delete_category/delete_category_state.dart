part of 'delete_category_cubit.dart';

abstract class DeleteCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteCategoryInitial extends DeleteCategoryState {}

class DeleteCategoryLoading extends DeleteCategoryState {}

class DeleteCategorySuccess extends DeleteCategoryState {
  final DeleteMainCategoryEntity entity;
  DeleteCategorySuccess(this.entity);
  @override
  List<Object?> get props => [entity.message];
}

class DeleteCategoryFailure extends DeleteCategoryState {
  final String message;
  DeleteCategoryFailure(this.message);
  @override
  List<Object?> get props => [message];
}
