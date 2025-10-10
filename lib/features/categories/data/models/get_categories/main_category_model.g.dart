// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCategoriesResponse _$MainCategoriesResponseFromJson(
  Map<String, dynamic> json,
) => MainCategoriesResponse(
  allCategories:
      (json['All Categories'] as List<dynamic>)
          .map((e) => MainCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MainCategoriesResponseToJson(
  MainCategoriesResponse instance,
) => <String, dynamic>{'All Categories': instance.allCategories};

MainCategoryModel _$MainCategoryModelFromJson(Map<String, dynamic> json) =>
    MainCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      branchId: (json['branch_id'] as num).toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$MainCategoryModelToJson(MainCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'branch_id': instance.branchId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
