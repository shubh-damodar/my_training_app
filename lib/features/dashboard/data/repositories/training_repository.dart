import 'dart:convert';

import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/features/dashboard/data/providers/training_provider.dart';

class DataRepository {
  final NetworkDataProvider _networkDataProvider = NetworkDataProvider();

  Future<TrainingModel> getTrainingModelFun() async {
    try {
      final String rawResponse = await _networkDataProvider.getAllTrainingsDataFun();

      final Map<String, dynamic> data = jsonDecode(rawResponse);

      return TrainingModel.fromJson(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
