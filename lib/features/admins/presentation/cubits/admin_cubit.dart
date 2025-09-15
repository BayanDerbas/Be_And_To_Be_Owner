import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminSuccess([]));

  void addAdmin(String name, String phone, String branchName) {
    if (state is AdminSuccess) {
      final admins = List<Map<String, String>>.from((state as AdminSuccess).admins);
      admins.add({
        'name': name,
        'phone': phone,
        'branch': branchName,
      });
      emit(AdminSuccess(admins));
    }
  }

  void editAdmin(int index, String name, String phone, String branchName) {
    if (state is AdminSuccess) {
      final admins = List<Map<String, String>>.from((state as AdminSuccess).admins);
      admins[index] = {
        'name': name,
        'phone': phone,
        'branch': branchName,
      };
      emit(AdminSuccess(admins));
    }
  }

  void deleteAdmin(int index) {
    if (state is AdminSuccess) {
      final admins = List<Map<String, String>>.from((state as AdminSuccess).admins);
      admins.removeAt(index);
      emit(AdminSuccess(admins));
    }
  }
}
