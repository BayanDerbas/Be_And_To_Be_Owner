import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class AdminModel{
  final String fullname;
  final String password;
  final String phonenumber;
  final int branch_id;

  AdminModel({required this.fullname, required this.password, required this.phonenumber, required this.branch_id});
  factory AdminModel.fromJson(Map<String, dynamic> json) => _$AdminModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}