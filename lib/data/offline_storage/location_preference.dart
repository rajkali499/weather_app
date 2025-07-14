import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/model/location_model.dart';

class LocationPrefs {
  static const String _keyLastLocation = "last_location";

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  /// Save last location
  static Future<void> saveLastLocation(LocationModel location) async {
    final prefs = _prefs!;
    final jsonString = jsonEncode(location.toJson());
    await prefs.setString(_keyLastLocation, jsonString);
  }

  /// Load last location
  static Future<LocationModel?> loadLastLocation() async {
    final prefs = _prefs!;
    final jsonString = prefs.getString(_keyLastLocation);
    if (jsonString == null) return null;
    try {
      return LocationModel.fromJson(jsonDecode(jsonString));
    } catch (_) {
      return null;
    }
  }

  /// Clear last location
  static Future<void> clearLastLocation() async {
    final prefs = _prefs!;
    await prefs.remove(_keyLastLocation);
  }
}
