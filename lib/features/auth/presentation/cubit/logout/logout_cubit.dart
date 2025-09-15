import 'package:bloc/bloc.dart';
import '../../../../../core/utils/secure_storage.dart';
import '../../../domain/usecases/logout/logout_usecase.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutUseCase logoutUseCase;
  LogoutCubit(this.logoutUseCase) : super(LogoutInitial());

  Future <void> logout() async {
    emit(LogoutLoading());
    final token = await SecureStorage.getToken();
    if(token == null){
      emit(LogoutFailure());
      return;
    }
    final result = await logoutUseCase("Bearer $token");
    result.fold(
            (failure) async {
              emit(LogoutFailure());
            },
            (response) async {
              await SecureStorage.deleteToken();
              emit(LogoutSuccess());
            },
    );
  }
}
