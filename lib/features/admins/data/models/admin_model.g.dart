// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
  fullname: json['fullname'] as String,
  password: json['password'] as String,
  phonenumber: json['phonenumber'] as String,
  branch_id: (json['branch_id'] as num).toInt(),
);

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'password': instance.password,
      'phonenumber': instance.phonenumber,
      'branch_id': instance.branch_id,
    };
