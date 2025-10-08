import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/admin_entity.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class AdminResponse {
  @JsonKey(name: 'all info')
  final List<AdminInfo> allInfo;

  AdminResponse({required this.allInfo});

  factory AdminResponse.fromJson(Map<String, dynamic> json) => _$AdminResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminResponseToJson(this);
}

@JsonSerializable()
class AdminInfo  {
  final int id;
  @JsonKey(name: 'branch_id')
  final int branchId;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final UserModel user;
  final BranchModel branch;

  AdminInfo({
    required this.id,
    required this.branchId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.branch,
  });

  factory AdminInfo.fromJson(Map<String, dynamic> json) => _$AdminInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AdminInfoToJson(this);

  AdminEntity toEntity() {
    return AdminEntity(
      id: id,
      fullname: user.fullname,
      phonenumber: user.phonenumber,
      branchName: branch.branchName,
      branchImage: branch.image ?? '',
    );
  }

  @override
  List<Object?> get props => [id, branchId, userId, user, branch];
}

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String fullname;
  final String phonenumber;
  final String role;
  final String? phone_verified_at;
  final String created_at;
  final String updated_at;

  UserModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.role,
    this.phone_verified_at,
    required this.created_at,
    required this.updated_at,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [id, fullname, phonenumber, role];
}

@JsonSerializable()
class BranchModel extends Equatable {
  final int id;
  @JsonKey(name: 'branch_name')
  final String branchName;
  final String? image;
  final double? length;
  final double? width;
  final String? facebooktoken;
  final String? instagramtoken;
  final String created_at;
  final String updated_at;

  BranchModel({
    required this.id,
    required this.branchName,
    this.image,
    this.length,
    this.width,
    this.facebooktoken,
    this.instagramtoken,
    required this.created_at,
    required this.updated_at,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => _$BranchModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  @override
  List<Object?> get props => [id, branchName];
}
