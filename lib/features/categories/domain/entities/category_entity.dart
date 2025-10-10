import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final int branchId;
  final String? createdAt;
  final String? updatedAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, image, branchId, createdAt, updatedAt];
}
