import 'package:weather_app/domain/bloc/weather_event.dart';

class SetSelectedDayEvent extends WeatherEvent {
  final int dayIndex;

  SetSelectedDayEvent(this.dayIndex);
}
