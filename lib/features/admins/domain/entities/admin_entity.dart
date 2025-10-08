// lib/features/admin/domain/entities/admin_entity.dart
import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  final int id;
  final String fullname;
  final String phonenumber;
  final String branchName;
  final String branchImage;

  const AdminEntity({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.branchName,
    required this.branchImage,
  });

  @override
  List<Object?> get props => [id, fullname, phonenumber, branchName, branchImage];
}