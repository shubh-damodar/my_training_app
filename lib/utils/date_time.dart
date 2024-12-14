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

String mmmDd(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('MMM dd');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}

String dd(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('dd');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}

String formatTime(String date) {
  DateTime dateTime = DateTime.parse(date);
  final formatter = DateFormat('hh:mm a');
  return formatter.format(dateTime);
}
