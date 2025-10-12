import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/meal_status_entity.dart';

part 'meal_status_response.g.dart';

@JsonSerializable()
class MealStatusResponse extends MealStatusEntity{
  MealStatusResponse({required super.message});
  factory MealStatusResponse.fromJson(Map<String,dynamic> json) => _$MealStatusResponseFromJson(json);
  Map<String,dynamic> toJson() => _$MealStatusResponseToJson(this);
}