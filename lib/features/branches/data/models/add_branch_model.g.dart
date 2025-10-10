// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBranchModel _$AddBranchModelFromJson(Map<String, dynamic> json) =>
    AddBranchModel(
      branchName: json['branchName'] as String?,
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      instagramtoken: json['instagramtoken'] as String?,
      facebooktoken: json['facebooktoken'] as String?,
      phones:
          (json['phones'] as List<dynamic>?)?.map((e) => e as String).toList(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$AddBranchModelToJson(AddBranchModel instance) =>
    <String, dynamic>{
      'branchName': instance.branchName,
      'length': instance.length,
      'width': instance.width,
      'instagramtoken': instance.instagramtoken,
      'facebooktoken': instance.facebooktoken,
      'phones': instance.phones,
      'image': instance.image,
    };
