import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/edit_branch_name_entity.dart';

part 'edit_branch_name_model.g.dart';
@JsonSerializable()
class EditBranchNameModel extends EditBranchNameEntity {
  EditBranchNameModel({required super.message});
  factory EditBranchNameModel.fromJson(Map<String, dynamic> json) =>
      _$EditBranchNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditBranchNameModelToJson(this);
}