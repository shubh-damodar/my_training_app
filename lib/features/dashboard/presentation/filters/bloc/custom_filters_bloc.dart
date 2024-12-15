import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/collections/global_data.dart';

part 'custom_filters_event.dart';
part 'custom_filters_state.dart';

class CustomFiltersBloc extends Bloc<CustomFiltersEvent, CustomFiltersState> {
  CustomFiltersBloc() : super(CustomFiltersInitial()) {
    on<SelectedFiltersEvent>(selectedFiltersEvent);
  }

  Future<void> selectedFiltersEvent(SelectedFiltersEvent event, Emitter<CustomFiltersState> emit) async {
    List<Map<String, dynamic>> updatedFilters = List.from(globalSaveList);

    for (var element in event.selectedSortValue ?? []) {
      if (element["isSelected"] as bool) {
        if (!updatedFilters.any((filter) => filter['name'] == element['name'])) {
          updatedFilters.add(element);
        }
      } else {
        updatedFilters.removeWhere((filter) => filter['name'] == element['name']);
      }
    }

    globalSaveList = updatedFilters;
    emit(SelectedFiltersState(selectedSortValue: event.selectedSortValue));
  }
}
