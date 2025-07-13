class WeatherCondition {
  final String description;
  final String emoji;
  final String icon;

  WeatherCondition({
    required this.description,
    required this.emoji,
    required this.icon,
  });
}

final Map<int, WeatherCondition> wmoWeatherMap = {
  0: WeatherCondition(description: "Clear sky", emoji: "☀️", icon: "clear_day"),
  1: WeatherCondition(description: "Mainly clear", emoji: "🌤️", icon: "mostly_clear"),
  2: WeatherCondition(description: "Partly cloudy", emoji: "⛅", icon: "partly_cloudy"),
  3: WeatherCondition(description: "Overcast", emoji: "☁️", icon: "cloudy"),
  45: WeatherCondition(description: "Fog", emoji: "🌫️", icon: "fog"),
  48: WeatherCondition(description: "Depositing rime fog", emoji: "🌫️❄️", icon: "fog_icy"),
  51: WeatherCondition(description: "Light drizzle", emoji: "🌦️", icon: "drizzle_light"),
  53: WeatherCondition(description: "Moderate drizzle", emoji: "🌦️", icon: "drizzle"),
  55: WeatherCondition(description: "Dense drizzle", emoji: "🌧️", icon: "drizzle_heavy"),
  56: WeatherCondition(description: "Light freezing drizzle", emoji: "🌧️❄️", icon: "freezing_drizzle_light"),
  57: WeatherCondition(description: "Dense freezing drizzle", emoji: "🌧️❄️", icon: "freezing_drizzle_heavy"),
  61: WeatherCondition(description: "Slight rain", emoji: "🌦️", icon: "rain_light"),
  63: WeatherCondition(description: "Moderate rain", emoji: "🌧️", icon: "rain"),
  65: WeatherCondition(description: "Heavy rain", emoji: "🌧️🌧️", icon: "rain_heavy"),
  66: WeatherCondition(description: "Light freezing rain", emoji: "🌧️❄️", icon: "freezing_rain_light"),
  67: WeatherCondition(description: "Heavy freezing rain", emoji: "🌧️❄️", icon: "freezing_rain_heavy"),
  71: WeatherCondition(description: "Slight snowfall", emoji: "🌨️", icon: "snow_light"),
  73: WeatherCondition(description: "Moderate snowfall", emoji: "🌨️", icon: "snow"),
  75: WeatherCondition(description: "Heavy snowfall", emoji: "❄️❄️", icon: "snow_heavy"),
  77: WeatherCondition(description: "Snow grains", emoji: "❄️", icon: "snow_grains"),
  80: WeatherCondition(description: "Slight rain showers", emoji: "🌦️", icon: "rain_showers_light"),
  81: WeatherCondition(description: "Moderate rain showers", emoji: "🌧️", icon: "rain_showers"),
  82: WeatherCondition(description: "Violent rain showers", emoji: "⛈️", icon: "rain_showers_heavy"),
  85: WeatherCondition(description: "Slight snow showers", emoji: "🌨️", icon: "snow_showers_light"),
  86: WeatherCondition(description: "Heavy snow showers", emoji: "❄️❄️", icon: "snow_showers_heavy"),
  95: WeatherCondition(description: "Thunderstorm", emoji: "⛈️", icon: "thunderstorm"),
  96: WeatherCondition(description: "Thunderstorm with slight hail", emoji: "⛈️🌨️", icon: "thunderstorm_hail_light"),
  99: WeatherCondition(description: "Thunderstorm with heavy hail", emoji: "⛈️❄️", icon: "thunderstorm_hail_heavy"),
};
