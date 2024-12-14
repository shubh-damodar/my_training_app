import 'package:flutter/services.dart' show rootBundle;

class NetworkDataProvider {
  Future<String> getAllTrainingsDataFun() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/trainings_dummy_date.json');
      return jsonString;
    } catch (e) {
      throw e.toString();
    }
  }
}
