part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final List<AdminEntity> admins;
  const AdminSuccess(this.admins);
  @override
  List<Object?> get props => [admins];
}

class AddAdminSuccess extends AdminState {
  final AddAdminEntity message;
  AddAdminSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object?> get props => [message];
}