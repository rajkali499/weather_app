import 'package:intl/intl.dart';
import 'package:weather_app/data/model/location_model.dart';

LocationModel? selectedLocation;

DateTime convertUnixToIST(int unixTimestamp) {
  DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(
    unixTimestamp * 1000,
    isUtc: true,
  );

  // Add IST offset (UTC+5:30) for Indian Standard Time
  DateTime istDateTime = utcDateTime.add(const Duration(hours: 5, minutes: 30));

  return istDateTime;
}

String getWeekdayName(DateTime date) {
  return DateFormat('EEEE').format(date); // 'EEEE' gives full weekday name
}

String formatDate(DateTime date) {
  return DateFormat('d MMM yyyy').format(date);
}
