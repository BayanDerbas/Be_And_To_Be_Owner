import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/delete_main_category_entity.dart';

part 'delete_main_category.g.dart';

@JsonSerializable()
class DeleteMainCategory extends DeleteMainCategoryEntity {
  DeleteMainCategory({required super.message});
  factory DeleteMainCategory.fromJson(Map<String,dynamic> json) => _$DeleteMainCategoryFromJson(json);
  Map<String,dynamic> toJson() => _$DeleteMainCategoryToJson(this);
}