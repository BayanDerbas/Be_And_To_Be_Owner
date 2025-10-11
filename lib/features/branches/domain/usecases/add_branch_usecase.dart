import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/repositories/branches_repository.dart';
import '../../../../core/networks/failures.dart';
import '../entities/add_branch_response_entity.dart';

class AddBranchUseCase {
  final BranchesRepository repository;

  AddBranchUseCase({required this.repository});

  Future<Either<Failure, AddBranchResponseEntity>> call({
    required String branch_name,
    required XFile image,
    required double length,
    required double width,
    String? facebooktoken,
    String? instagramtoken,
    required List<String> numbers,
  }) async {
    return repository.addBranch(
      branch_name: branch_name,
      image: image,
      length: length,
      width: width,
      numbers: numbers,
    );
  }
}
