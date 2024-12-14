part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardGetDataEvent extends DashboardEvent {}

class LeftArrowEvent extends DashboardEvent {}

class RightArrowEvent extends DashboardEvent {}

class GetAllDataEvent extends DashboardEvent {}

class GetFilterDataEvent extends DashboardEvent {
  final String? location;
  final String? trainingName;
  final String? trainer;
  GetFilterDataEvent({this.location, this.trainingName, this.trainer});
}

class FilterWithQueryEvent extends DashboardEvent {
  final String? query;
  FilterWithQueryEvent({this.query});
}
