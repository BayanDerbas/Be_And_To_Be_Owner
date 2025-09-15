import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/logout/logout_entity.dart';

part 'logout_model.g.dart';

@JsonSerializable()
class LogoutModel extends LogoutEntity {
  final String? message;

  LogoutModel({required this.message}) : super(message: message);
  factory LogoutModel.fromJson(Map<String,dynamic> json) => _$LogoutModelFromJson(json);
  Map<String,dynamic> toJson() => _$LogoutModelToJson(this);
}
