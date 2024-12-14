import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/collections/global_data.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/features/dashboard/data/repositories/training_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitialState()) {
    final DataRepository weatherRepository = DataRepository();

    on<GetAllDataEvent>((GetAllDataEvent event, Emitter<DashboardState> emit) async {
      emit(DashboardLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        TrainingModel data = await weatherRepository.getTrainingModelFun();
        emit(DashboardSuccessState(trainingModel: data));
      } catch (e) {
        emit(DashboardErrorState(error: e.toString())); // Handle errors
      }
    });

    on<GetFilterDataEvent>((GetFilterDataEvent event, Emitter<DashboardState> emit) async {
      emit(DashboardFilterListLoadingState());
      await Future.delayed(const Duration(seconds: 1));

      try {
        TrainingModel data = await weatherRepository.getTrainingModelFun();

        emit(FilteredFromSortState(trainingList: data.trainings));
      } catch (e) {
        emit(DashboardErrorState(error: e.toString()));
      }
    });

    on<FilterWithQueryEvent>((FilterWithQueryEvent event, Emitter<DashboardState> emit) async {
      try {
        TrainingModel data = await weatherRepository.getTrainingModelFun();

        List<Training> trainings = data.trainings;

        List<String> sortedStrings = [];

        switch (event.query) {
          case 'Location':
            sortedStrings = trainings.map((training) => training.location).toList();
            sortedStrings.sort();
            break;
          case 'Training name':
            sortedStrings = trainings.map((training) => training.trainingName).toList();
            sortedStrings.sort();
            break;
          case 'Trainer':
            sortedStrings = trainings.map((training) => training.trainer).toList();
            sortedStrings.sort();
            break;
          default:
            break;
        }

        Set<String> uniqueStrings = Set.from(sortedStrings);

        List<Map<String, Object>> updatedList = uniqueStrings.map((str) {
          return {
            'name': str,
            'isSelected': globalSaveList.any((element) => element['name'] == str && element['isSelected'] as bool),
          };
        }).toList();

        emit(FilteredFromSortState(selectedSortList: updatedList, selectedSortString: event.query, trainingList: data.trainings));
      } catch (e) {
        emit(DashboardErrorState(error: e.toString()));
      }
    });
  }
}
