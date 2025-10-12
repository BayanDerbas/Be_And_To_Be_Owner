import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/features/meals/domain/entities/add_meal_entity.dart';

part 'add_meal_model.g.dart';

@JsonSerializable()
class AddMealModel extends AddMealEntity {
  AddMealModel(super.message);
  factory AddMealModel.fromJson(Map<String,dynamic> json) => _$AddMealModelFromJson(json);
  Map<String,dynamic> toJson() => _$AddMealModelToJson(this);
}