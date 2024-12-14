part of 'custom_filters_bloc.dart';

@immutable
sealed class CustomFiltersState {}

final class CustomFiltersInitial extends CustomFiltersState {}

final class CustomFiltersLoading extends CustomFiltersState {}

final class SelectedFiltersState extends CustomFiltersState {
  final List<Map<String, dynamic>>? selectedSortValue;
  SelectedFiltersState({this.selectedSortValue});
}
