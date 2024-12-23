import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/collections/global_data.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/features/dashboard/data/repositories/training_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DataRepository weatherRepository = DataRepository();

  DashboardBloc() : super(DashboardInitialState()) {
    on<GetAllDataEvent>(getAllDataEvent);
    on<GetFilterDataEvent>(getFilteredDataEvent);
    on<FilterWithQueryEvent>(filterWithQueryEvent);
    on<FilterWithLocationEvent>(filterWithLocationEvent);
  }

  Future<void> getAllDataEvent(GetAllDataEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      TrainingModel data = await weatherRepository.getTrainingModelFun();
      emit(DashboardSuccessState(trainingModel: data));
    } catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }

  Future<void> getFilteredDataEvent(GetFilterDataEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      TrainingModel data = await weatherRepository.getTrainingModelFun();
      emit(FilteredFromSortState(trainingList: data.trainings));
    } catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }

  Future<void> filterWithQueryEvent(FilterWithQueryEvent event, Emitter<DashboardState> emit) async {
    try {
      TrainingModel data = await weatherRepository.getTrainingModelFun();

      List<Training> trainings = data.trainings;

      List<String> sortedStrings = [];

      switch (event.query) {
        case 'Location':
          sortedStrings = trainings.map((training) => training.location).toList();
          break;
        case 'Training Name':
          sortedStrings = trainings.map((training) => training.trainingName).toList();
          break;
        case 'Trainer':
          sortedStrings = trainings.map((training) => training.trainer).toList();
          break;
        default:
          break;
      }

      sortedStrings.sort();

      Set<String> uniqueStrings = Set.from(sortedStrings);

      List<Map<String, dynamic>> updatedList = uniqueStrings.map((str) {
        return {
          'name': str,
          'isSelected': globalSaveList.any((element) => element['name'] == str && element['isSelected'] as bool),
          'type': event.query,
        };
      }).toList();

      emit(FilteredFromSortState(selectedSortList: updatedList, selectedSortString: event.query, trainingList: data.trainings));
    } catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }

  Future<void> filterWithLocationEvent(FilterWithLocationEvent event, Emitter<DashboardState> emit) async {
    try {
      TrainingModel data = await weatherRepository.getTrainingModelFun();

      if (event.newList.isEmpty) {
        emit(FilteredFromSortState(trainingList: data.trainings));
        return;
      }

      final locationFilters = event.newList.where((item) => item['type'] == 'Location').map((item) => item['name']).toSet();
      final trainerFilters = event.newList.where((item) => item['type'] == 'Trainer').map((item) => item['name']).toSet();
      final trainingNameFilters = event.newList.where((item) => item['type'] == 'Training Name').map((item) => item['name']).toSet();

      List<Training> tempData = data.trainings.where((training) {
        final locationMatch = locationFilters.contains(training.location);
        final trainerMatch = trainerFilters.contains(training.trainer);
        final trainingNameMatch = trainingNameFilters.contains(training.trainingName);

        if (locationFilters.isNotEmpty && !locationMatch) return false;
        if (trainerFilters.isNotEmpty && !trainerMatch) return false;
        if (trainingNameFilters.isNotEmpty && !trainingNameMatch) return false;
        //Early return for optimization ----->

        if (locationFilters.isNotEmpty && trainerFilters.isNotEmpty && trainingNameFilters.isNotEmpty) {
          return locationMatch && trainerMatch && trainingNameMatch;
        } else if (locationFilters.isNotEmpty && trainerFilters.isNotEmpty) {
          return locationMatch && trainerMatch;
        } else if (locationFilters.isNotEmpty && trainingNameFilters.isNotEmpty) {
          return locationMatch && trainingNameMatch;
        } else if (trainerFilters.isNotEmpty && trainingNameFilters.isNotEmpty) {
          return trainerMatch && trainingNameMatch;
        } else if (locationFilters.isNotEmpty) {
          return locationMatch;
        } else if (trainerFilters.isNotEmpty) {
          return trainerMatch;
        } else if (trainingNameFilters.isNotEmpty) {
          return trainingNameMatch;
        } else {
          return false;
        }
      }).toList();

      emit(FilteredFromSortState(trainingList: tempData));
    } catch (e) {
      emit(DashboardErrorState(error: e.toString()));
    }
  }
}
