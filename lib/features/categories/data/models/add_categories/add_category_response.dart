import 'package:json_annotation/json_annotation.dart';

part 'add_category_response.g.dart';

@JsonSerializable()
class AddCategoryResponse {
  final String message;
  AddCategoryResponse({required this.message});

  factory AddCategoryResponse.fromJson(Map<String,dynamic> json) => _$AddCategoryResponseFromJson(json);
  Map<String,dynamic> toJson() => _$AddCategoryResponseToJson(this);
}