import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/entities/add_branch_response_entity.dart';
import '../../../../core/networks/failures.dart';
import '../entities/branches_entity.dart';

abstract class BranchesRepository{
  Future <Either<Failure,BranchesEntity>> getBranches ();

  Future<Either<Failure, AddBranchResponseEntity>> addBranch({
    required String branch_name,
    required XFile image,
    required double length,
    required double width,
    String? facebooktoken,
    String? instagramtoken,
    required List<String> numbers,
  });
}