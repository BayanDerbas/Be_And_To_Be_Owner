import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/category_entity.dart';

part 'main_category_model.g.dart';

@JsonSerializable()
class MainCategoriesResponse {
  @JsonKey(name: 'All Categories')
  final List<MainCategoryModel> allCategories;

  MainCategoriesResponse({required this.allCategories});

  factory MainCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$MainCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoriesResponseToJson(this);
}

@JsonSerializable()
class MainCategoryModel {
  final int id;
  final String name;
  final String image;
  @JsonKey(name: 'branch_id')
  final int branchId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  MainCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoryModelToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      image: image,
      branchId: branchId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
