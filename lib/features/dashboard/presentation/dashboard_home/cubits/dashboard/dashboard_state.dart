part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable{}

final class DashboardInitial extends DashboardState {
  final int currentIndex;

  DashboardInitial({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];

}
