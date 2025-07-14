class TextHelper {
  TextHelper._internal();

  static final TextHelper _instance = TextHelper._internal();

  factory TextHelper() {
    return _instance;
  }

  static const String appName = "Weather App";
  static const String searchHintText = "Search...";
  static const String recentLocations = "Recent Locations";
  static const String selectLocation = "Select Location";
  static const String searchLocations = "Search Locations";
  static const String noResults = "No results";
  static const String failedToLoadLocations = "Failed to load locations";
  static const String  wind = "WIND";
  static const String  humidity = "HUMIDITY";
  static const String  precipitation = "PRECIPITATION";
  static const String locationNotFound = "Location not found";
  static const String welcomeText = "Welcome to WeatherApp 🌤️";
  static const String locationPromptText = "Please select a location to get started";
  static const String changeLocation = "Change Location";
}