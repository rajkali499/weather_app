class LocationModel {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double? elevation;
  final String? timezone;
  final String country;
  final String? admin1;
  final String? admin2;
  final String? admin3;
  final String? admin4;
  final int? population;
  final String? featureCode;
  final String? countryCode;
  final int? admin1Id;
  final int? admin2Id;
  final int? admin3Id;
  final int? admin4Id;
  final int? countryId;

  LocationModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.elevation,
    this.timezone,
    required this.country,
    this.admin1,
    this.admin2,
    this.admin3,
    this.admin4,
    this.population,
    this.featureCode,
    this.countryCode,
    this.admin1Id,
    this.admin2Id,
    this.admin3Id,
    this.admin4Id,
    this.countryId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      elevation: (json['elevation'] as num?)?.toDouble(),
      timezone: json['timezone'],
      country: json['country'],
      admin1: json['admin1'],
      admin2: json['admin2'],
      admin3: json['admin3'],
      admin4: json['admin4'],
      population: json['population'],
      featureCode: json['feature_code'],
      countryCode: json['country_code'],
      admin1Id: json['admin1_id'],
      admin2Id: json['admin2_id'],
      admin3Id: json['admin3_id'],
      admin4Id: json['admin4_id'],
      countryId: json['country_id'],
    );
  }
}
