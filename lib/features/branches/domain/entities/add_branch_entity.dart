import 'package:equatable/equatable.dart';

class AddBranchEntity extends Equatable {
  final String? branchName;
  final double? length;
  final double? width;
  final String? instagramtoken;
  final String? facebooktoken;
  final List<String>? phones;
  final String? image;

  const AddBranchEntity({
    this.branchName,
    this.length,
    this.width,
    this.instagramtoken,
    this.facebooktoken,
    this.phones,
    this.image,
  });

  @override
  List<Object?> get props => [
    branchName,
    length,
    width,
    instagramtoken,
    facebooktoken,
    phones,
    image,
  ];
}
