import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/add_branch_entity.dart';

part 'add_branch_model.g.dart';

@JsonSerializable()
class AddBranchModel extends AddBranchEntity {
  const AddBranchModel({
    String? branchName,
    double? length,
    double? width,
    String? instagramtoken,
    String? facebooktoken,
    List<String>? phones,
    String? image,
  }) : super(
    branchName: branchName,
    length: length,
    width: width,
    instagramtoken: instagramtoken,
    facebooktoken: facebooktoken,
    phones: phones,
    image: image,
  );

  factory AddBranchModel.fromJson(Map<String, dynamic> json) =>
      _$AddBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddBranchModelToJson(this);
}
