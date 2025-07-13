import 'package:weather_app/data/remote_data_source/weather_remote_datasource.dart';
import 'package:weather_app/data/model/api_response.dart';
import 'package:weather_app/data/model/location_response.dart';

class GetLocationsUseCase {
  final WeatherRemoteDataSource remoteDataSource;

  GetLocationsUseCase({required this.remoteDataSource});

  Future<ApiResponse<LocationSearchResponse>> call(String query) {
    return remoteDataSource.getLocations(query);
  }
}
