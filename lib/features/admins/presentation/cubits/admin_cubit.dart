import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/features/admins/data/models/admin_model.dart';
import '../../domain/entities/admin_entity.dart';
import '../../domain/usecases/get_admins_usecase.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final GetAdminsUseCase getAdminsUseCase;

  AdminCubit(this.getAdminsUseCase) : super(AdminInitial());

  Future<void> fetchAdmins() async {
    emit(AdminLoading());
    final res = await getAdminsUseCase();
    res.fold(
          (failure) => emit(AdminError(failure.message)),
          (admins) => emit(AdminSuccess(admins)),
    );
  }


  void addAdminLocally(AdminEntity admin) {
    if (state is AdminSuccess) {
      final list = List<AdminEntity>.from((state as AdminSuccess).admins)..add(admin);
      emit(AdminSuccess(list));
    }
  }

  void editAdminLocally(int index, AdminEntity newAdmin) {
    if (state is AdminSuccess) {
      final list = List<AdminEntity>.from((state as AdminSuccess).admins);
      if (index >= 0 && index < list.length) {
        list[index] = newAdmin;
        emit(AdminSuccess(list));
      }
    }
  }

  void deleteAdminLocally(int index) {
    if (state is AdminSuccess) {
      final list = List<AdminEntity>.from((state as AdminSuccess).admins)..removeAt(index);
      emit(AdminSuccess(list));
    }
  }
}