// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminResponse _$AdminResponseFromJson(Map<String, dynamic> json) =>
    AdminResponse(
      allInfo:
          (json['all info'] as List<dynamic>)
              .map((e) => AdminInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AdminResponseToJson(AdminResponse instance) =>
    <String, dynamic>{'all info': instance.allInfo};

AdminInfo _$AdminInfoFromJson(Map<String, dynamic> json) => AdminInfo(
  id: (json['id'] as num).toInt(),
  branchId: (json['branch_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  branch: BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AdminInfoToJson(AdminInfo instance) => <String, dynamic>{
  'id': instance.id,
  'branch_id': instance.branchId,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'user': instance.user,
  'branch': instance.branch,
};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  fullname: json['fullname'] as String,
  phonenumber: json['phonenumber'] as String,
  role: json['role'] as String,
  phone_verified_at: json['phone_verified_at'] as String?,
  created_at: json['created_at'] as String,
  updated_at: json['updated_at'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'fullname': instance.fullname,
  'phonenumber': instance.phonenumber,
  'role': instance.role,
  'phone_verified_at': instance.phone_verified_at,
  'created_at': instance.created_at,
  'updated_at': instance.updated_at,
};

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  id: (json['id'] as num).toInt(),
  branchName: json['branch_name'] as String,
  image: json['image'] as String?,
  length: (json['length'] as num?)?.toDouble(),
  width: (json['width'] as num?)?.toDouble(),
  facebooktoken: json['facebooktoken'] as String?,
  instagramtoken: json['instagramtoken'] as String?,
  created_at: json['created_at'] as String,
  updated_at: json['updated_at'] as String,
);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_name': instance.branchName,
      'image': instance.image,
      'length': instance.length,
      'width': instance.width,
      'facebooktoken': instance.facebooktoken,
      'instagramtoken': instance.instagramtoken,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
