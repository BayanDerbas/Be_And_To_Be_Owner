import 'package:equatable/equatable.dart';

class DeleteMainCategoryEntity extends Equatable{
  final String? message;
  DeleteMainCategoryEntity({required this.message});
  @override
  List<Object?> get props => [message];

}