import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/networks/failures.dart';
import '../../../domain/entities/add_branch_response_entity.dart';
import '../../../domain/usecases/add_branch_usecase.dart';

part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  final AddBranchUseCase addBranchUseCase;

  AddBranchCubit({required this.addBranchUseCase}) : super(AddBranchInitial());

  Future<void> addBranch({
    required String branchName,
    required XFile image,
    required List<String> numbers,
    required double length,
    required double width,
    String? facebook,
    String? instagram,
  }) async {
    emit(AddBranchLoading());

    final Either<Failure, AddBranchResponseEntity> result = await addBranchUseCase(
      branch_name: branchName,
      image: image,
      numbers: numbers,
      length: length,
      width: width,
      facebook: facebook,
      instagram: instagram,
    );

    result.fold(
          (failure) => emit(AddBranchFailure(error: failure.message)),
          (response) => emit(AddBranchSuccess(message: "تمت إضافة الفرع بنجاح")),
    );
  }
}
