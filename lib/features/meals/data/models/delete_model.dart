import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/features/meals/domain/entities/delete_entity.dart';

part 'delete_model.g.dart';

@JsonSerializable()
class DeleteModel extends DeleteEntity{
  DeleteModel(super.message);
  factory DeleteModel.fromJson(Map<String,dynamic> json) => _$DeleteModelFromJson(json);
  Map<String,dynamic> toJson() => _$DeleteModelToJson(this);
}