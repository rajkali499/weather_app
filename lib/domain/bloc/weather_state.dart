import 'package:weather_app/data/model/location_response.dart';
import 'package:weather_app/data/model/weather_forecast_response.dart';

class WeatherState {
  final ProgressStatus getWeatherStatus;
  final WeatherForecastResponse? weather;
  final LocationSearchResponse? locations;
  final ProgressStatus getLocationsStatus;
  final String? errorMessage;
  final int selectedDay;

  WeatherState({
    this.getWeatherStatus = ProgressStatus.initial,
    this.weather,
    this.locations,
    this.getLocationsStatus = ProgressStatus.initial,
    this.errorMessage,
    this.selectedDay = 0,
  });

  WeatherState copyWith({
    ProgressStatus? getWeatherStatus,
    WeatherForecastResponse? weather,
    LocationSearchResponse? locations,
    ProgressStatus? getLocationsStatus,
    String? errorMessage,
    int? selectedDay,
  }) {
    return WeatherState(
      getWeatherStatus: getWeatherStatus ?? this.getWeatherStatus,
      weather: weather ?? this.weather,
      locations: locations ?? this.locations,
      getLocationsStatus: getLocationsStatus ?? this.getLocationsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  } 
}

enum ProgressStatus { initial, loading, success, failure }
