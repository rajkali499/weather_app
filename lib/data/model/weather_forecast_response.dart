class WeatherForecastResponse {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnits currentUnits;
  final CurrentWeather current;
  final DailyUnits dailyUnits;
  final DailyWeather daily;

  WeatherForecastResponse({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) {
    return WeatherForecastResponse(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      generationTimeMs: (json['generationtime_ms'] as num).toDouble(),
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: (json['elevation'] as num).toDouble(),
      currentUnits: CurrentUnits.fromJson(json['current_units']),
      current: CurrentWeather.fromJson(json['current']),
      dailyUnits: DailyUnits.fromJson(json['daily_units']),
      daily: DailyWeather.fromJson(json['daily']),
    );
  }
}

class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String weatherCode;
  final String windSpeed10m;
  final String precipitation;

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.weatherCode,
    required this.windSpeed10m,
    required this.precipitation,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      weatherCode: json['weather_code'],
      windSpeed10m: json['wind_speed_10m'],
      precipitation: json['precipitation'],
    );
  }
}

class CurrentWeather {
  final int time;
  final int interval;
  final double temperature;
  final int relativeHumidity;
  final int weatherCode;
  final double windSpeed;
  final double precipitation;

  CurrentWeather({
    required this.time,
    required this.interval,
    required this.temperature,
    required this.relativeHumidity,
    required this.weatherCode,
    required this.windSpeed,
    required this.precipitation,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'],
      interval: json['interval'],
      temperature: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity: json['relative_humidity_2m'],
      weatherCode: json['weather_code'],
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
    );
  }
}

class DailyUnits {
  final String time;
  final String weatherCode;
  final String temperature2mMax;
  final String precipitationSum;
  final String windSpeed10mMax;

  DailyUnits({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.precipitationSum,
    required this.windSpeed10mMax,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'],
      weatherCode: json['weather_code'],
      temperature2mMax: json['temperature_2m_max'],
      precipitationSum: json['precipitation_sum'],
      windSpeed10mMax: json['wind_speed_10m_max'],
    );
  }
}

class DailyWeather {
  final List<int> time;
  final List<int> weatherCode;
  final List<double> temperature2mMax;
  final List<double> precipitationSum;
  final List<double> windSpeed10mMax;

  DailyWeather({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.precipitationSum,
    required this.windSpeed10mMax,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: List<int>.from(json['time']),
      weatherCode: List<int>.from(json['weather_code']),
      temperature2mMax: (json['temperature_2m_max'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
      precipitationSum: (json['precipitation_sum'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
      windSpeed10mMax: (json['wind_speed_10m_max'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}

