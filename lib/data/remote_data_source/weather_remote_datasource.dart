import 'package:weather_app/data/api_client.dart';
import 'package:weather_app/data/api_endpoints.dart';
import 'package:weather_app/data/model/api_response.dart';
import 'package:weather_app/data/model/location_response.dart';
import 'package:weather_app/data/model/weather_forecast_response.dart';

abstract class WeatherRemoteDataSource {
  Future<ApiResponse<LocationSearchResponse>> getLocations(String query);

  Future<ApiResponse<WeatherForecastResponse>> getWeather({
    required double latitude,
    required double longitude,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<ApiResponse<LocationSearchResponse>> getLocations(String query) {
    return ApiClient.callApi<LocationSearchResponse>(
      endpoint: ApiEndpoints.getLocations,
      method: HttpMethod.get,
      fromJson: (json) => LocationSearchResponse.fromJson(json),
      queryParams: {'name': query},
    );
  }

  @override
  Future<ApiResponse<WeatherForecastResponse>> getWeather({
    required double latitude,
    required double longitude,
  }) {
    return ApiClient.callApi<WeatherForecastResponse>(
      endpoint: ApiEndpoints.getWeather,
      method: HttpMethod.get,
      fromJson: (json) => WeatherForecastResponse.fromJson(json),
      queryParams: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'hourly': 'temperature_2m',
        'daily':
            'weather_code,temperature_2m_max,precipitation_sum,wind_speed_10m_max',
        'current':
            'temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m,precipitation',
        'format': 'json',
        'timeformat': 'unixtime',
        'timezone': 'IST',
      },
    );
  }
}
