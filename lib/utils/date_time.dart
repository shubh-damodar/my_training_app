import 'package:intl/intl.dart';

String ddMMM(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('dd MMM');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}

String yyyy(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('yyyy');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}
