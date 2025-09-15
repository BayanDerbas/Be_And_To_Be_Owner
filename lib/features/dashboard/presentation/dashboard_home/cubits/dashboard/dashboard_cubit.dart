import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial(currentIndex: -1));

  void changePage(int index){
    emit(DashboardInitial(currentIndex: index));
  }
}
