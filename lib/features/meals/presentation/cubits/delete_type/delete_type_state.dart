part of 'delete_type_cubit.dart';

abstract class DeleteTypeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteTypeInitial extends DeleteTypeState {}

class DeleteTypeLoading extends DeleteTypeState {}

class DeleteTypeSuccess extends DeleteTypeState {
  final DeleteEntity entity;
  DeleteTypeSuccess(this.entity);
  @override
  List<Object?> get props => [entity.message];
}

class DeleteTypeFailure extends DeleteTypeState {
  final String message;

  DeleteTypeFailure(this.message);
  @override
  List<Object?> get props => [message];
}
