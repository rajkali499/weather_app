import 'package:weather_app/domain/bloc/weather_event.dart';

class GetWeatherEvent extends WeatherEvent {
  final double latitude;
  final double longitude;

  GetWeatherEvent({required this.latitude, required this.longitude});
}