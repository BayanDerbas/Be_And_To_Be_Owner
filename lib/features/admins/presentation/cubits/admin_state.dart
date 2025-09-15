part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {}

class AdminInitial extends AdminState {
  @override
  List<Object?> get props => [];
}

class AdminSuccess extends AdminState {
  final List<Map<String, String>> admins;
  AdminSuccess(this.admins);

  @override
  List<Object?> get props => admins;
}
