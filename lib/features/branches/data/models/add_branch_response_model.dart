import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/features/branches/domain/entities/add_branch_response_entity.dart';

part 'add_branch_response_model.g.dart';

@JsonSerializable()
class AddBranchResponseModel extends AddBranchResponseEntity{
  AddBranchResponseModel({required super.message});
  factory AddBranchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddBranchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddBranchResponseModelToJson(this);
}