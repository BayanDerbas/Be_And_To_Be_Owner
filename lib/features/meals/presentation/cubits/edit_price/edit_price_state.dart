part of 'edit_price_cubit.dart';

abstract class EditPriceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditPriceInitial extends EditPriceState {}
class EditPriceLoading extends EditPriceState {}
class EditPriceSuccess extends EditPriceState {
  final AddMealEntity entity;
  EditPriceSuccess(this.entity);
  @override
  List<Object?> get props => [entity.message];
}
class EditPriceFailure extends EditPriceState {
  final String message;
  EditPriceFailure(this.message);
  @override
  List<Object?> get props => [message];
}
