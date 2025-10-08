import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/features/admins/domain/entities/add_admin_entity.dart';

part 'add_admin_model.g.dart';

@JsonSerializable()
class AddAdminModel extends AddAdminEntity {
  AddAdminModel({required super.message});
  factory AddAdminModel.fromJson(Map<String, dynamic> json) =>
      _$AddAdminModelFromJson(json);
  Map<String,dynamic> toJson() => _$AddAdminModelToJson(this);
}