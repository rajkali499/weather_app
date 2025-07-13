import 'package:weather_app/data/remote_data_source/weather_remote_datasource.dart';
import 'package:weather_app/data/model/api_response.dart';
import 'package:weather_app/data/model/weather_forecast_response.dart';

class GetWeatherReportUseCase {
  final WeatherRemoteDataSource remoteDataSource;

  GetWeatherReportUseCase({required this.remoteDataSource});

  Future<ApiResponse<WeatherForecastResponse>> call({
    required double latitude,
    required double longitude,
  }) {
    return remoteDataSource.getWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
