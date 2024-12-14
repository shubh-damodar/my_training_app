part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitialState extends DashboardState {}

final class DashboardLoadingState extends DashboardState {}

final class DashboardSuccessState extends DashboardState {
  final TrainingModel trainingModel;
  DashboardSuccessState({required this.trainingModel});
}

final class DashboardFilterListLoadingState extends DashboardState {}

final class FilteredFromSortState extends DashboardState {
  final List<Map<String, Object>>? selectedSortList;
  final String? selectedSortString;
  final List<Training>? trainingList;

  FilteredFromSortState({this.selectedSortList, this.selectedSortString, this.trainingList});
}

final class DashboardErrorState extends DashboardState {
  final String? error;
  DashboardErrorState({this.error});
}
