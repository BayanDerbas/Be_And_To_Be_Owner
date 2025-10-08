import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/features/admins/data/models/admin_model.dart';
import 'package:untitled/features/admins/domain/entities/add_admin_entity.dart';
import 'package:untitled/features/admins/domain/usecases/add_admin_usecase.dart';
import '../../domain/entities/admin_entity.dart';
import '../../domain/usecases/get_admins_usecase.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final GetAdminsUseCase getAdminsUseCase;
  final AddAdminUseCase addAdminUseCase;

  AdminCubit(this.getAdminsUseCase, this.addAdminUseCase)
    : super(AdminInitial());

  Future<void> fetchAdmins() async {
    emit(AdminLoading());
    final res = await getAdminsUseCase();
    res.fold(
      (failure) => emit(AdminError(failure.message)),
      (admins) => emit(AdminSuccess(admins)),
    );
  }

  Future<void> addAdmin({
    required String fullname,
    required String password,
    required String phonenumber,
    required int branch_id,
  }) async {
    emit(AdminLoading());
    final res = await addAdminUseCase.call(
      fullname: fullname,
      password: password,
      phonenumber: phonenumber,
      branch_id: branch_id,
    );
    res.fold((failure) => emit(AdminError(failure.message)), (entity) {
      emit(AddAdminSuccess(entity));
      fetchAdmins();
    });
  }
}
