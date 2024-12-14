part of 'custom_filters_bloc.dart';

@immutable
sealed class CustomFiltersEvent {}

class SelectedFiltersEvent extends CustomFiltersEvent {
  final List<Map<String, Object>>? selectedSortValue;
  SelectedFiltersEvent({this.selectedSortValue});
}
