import 'package:weather_app/domain/bloc/weather_event.dart';

class GetLocationsEvent extends WeatherEvent {
  final String query;

  GetLocationsEvent({required this.query});
}