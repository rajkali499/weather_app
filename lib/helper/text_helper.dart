class TextHelper {
  TextHelper._internal();

  static final TextHelper _instance = TextHelper._internal();

  factory TextHelper() {
    return _instance;
  }

  static const String appName = "Weather App";
  static const String searchHintText = "Search...";
  static const String recentLocations = "Recent Locations";
  static const String searchLocations = "Search Locations";
  static const String noResults = "No results";
  static const String failedToLoadLocations = "Failed to load locations";
}