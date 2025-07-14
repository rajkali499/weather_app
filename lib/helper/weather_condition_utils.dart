import 'package:weather_app/helper/asset_helper.dart';

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
  // Clear sky
  0: WeatherCondition(description: "Clear sky", emoji: "☀️", icon: AssetHelper.sunny),

  // Mainly clear, partly cloudy, and overcast
  1: WeatherCondition(description: "Mainly clear", emoji: "🌤️", icon: AssetHelper.partySun),
  2: WeatherCondition(description: "Partly cloudy", emoji: "⛅", icon: AssetHelper.partyCloudy),
  3: WeatherCondition(description: "Overcast", emoji: "☁️", icon: AssetHelper.cloudy),

  // Fog and depositing rime fog
  45: WeatherCondition(description: "Fog", emoji: "🌫️", icon: AssetHelper.cloudy),
  48: WeatherCondition(description: "Depositing rime fog", emoji: "🌫️❄️", icon: AssetHelper.cloudy),

  // Drizzle: Light, moderate, dense
  51: WeatherCondition(description: "Light drizzle", emoji: "🌦️", icon: AssetHelper.weatherIcon),
  53: WeatherCondition(description: "Moderate drizzle", emoji: "🌦️", icon: AssetHelper.weatherIcon),
  55: WeatherCondition(description: "Dense drizzle", emoji: "🌧️", icon: AssetHelper.rainy),

  // Freezing Drizzle
  56: WeatherCondition(description: "Light freezing drizzle", emoji: "🌧️❄️", icon: AssetHelper.rainy),
  57: WeatherCondition(description: "Dense freezing drizzle", emoji: "🌧️❄️", icon: AssetHelper.rainy),

  // Rain: Slight, moderate, heavy
  61: WeatherCondition(description: "Slight rain", emoji: "🌦️", icon: AssetHelper.weatherIcon),
  63: WeatherCondition(description: "Moderate rain", emoji: "🌧️", icon: AssetHelper.rainy),
  65: WeatherCondition(description: "Heavy rain", emoji: "🌧️🌧️", icon: AssetHelper.rainy),

  // Freezing rain
  66: WeatherCondition(description: "Light freezing rain", emoji: "🌧️❄️", icon: AssetHelper.rainy),
  67: WeatherCondition(description: "Heavy freezing rain", emoji: "🌧️❄️", icon: AssetHelper.rainy),

  // Snow fall
  71: WeatherCondition(description: "Slight snowfall", emoji: "🌨️", icon: AssetHelper.happyWinter),
  73: WeatherCondition(description: "Moderate snowfall", emoji: "🌨️", icon: AssetHelper.happyWinter),
  75: WeatherCondition(description: "Heavy snowfall", emoji: "❄️❄️", icon: AssetHelper.happyWinter),

  // Snow grains
  77: WeatherCondition(description: "Snow grains", emoji: "❄️", icon: AssetHelper.happyWinter),

  // Rain showers
  80: WeatherCondition(description: "Slight rain showers", emoji: "🌦️", icon: AssetHelper.weatherIcon),
  81: WeatherCondition(description: "Moderate rain showers", emoji: "🌧️", icon: AssetHelper.weatherIcon),
  82: WeatherCondition(description: "Violent rain showers", emoji: "⛈️", icon: AssetHelper.rainy),

  // Snow showers
  85: WeatherCondition(description: "Slight snow showers", emoji: "🌨️", icon: AssetHelper.happyWinter),
  86: WeatherCondition(description: "Heavy snow showers", emoji: "❄️❄️", icon: AssetHelper.happyWinter),

  // Thunderstorms
  95: WeatherCondition(description: "Thunderstorm", emoji: "⛈️", icon: AssetHelper.rainy),
  96: WeatherCondition(description: "Thunderstorm with slight hail", emoji: "⛈️🌨️", icon: AssetHelper.rainy),
  99: WeatherCondition(description: "Thunderstorm with heavy hail", emoji: "⛈️❄️", icon: AssetHelper.rainy),
};
