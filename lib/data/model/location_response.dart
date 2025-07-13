import 'location_model.dart';

class LocationSearchResponse {
  final List<LocationModel> results;
  final double generationTimeMs;

  LocationSearchResponse({
    required this.results,
    required this.generationTimeMs,
  });

  factory LocationSearchResponse.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((item) => LocationModel.fromJson(item))
        .toList();

    return LocationSearchResponse(
      results: results,
      generationTimeMs: (json['generationtime_ms'] as num).toDouble(),
    );
  }
}
