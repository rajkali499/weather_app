import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/bloc/get_locations_event.dart';
import 'package:weather_app/domain/bloc/get_weather_event.dart';
import 'package:weather_app/domain/bloc/set_selected_day_event.dart';
import 'package:weather_app/domain/bloc/weather_event.dart';
import 'package:weather_app/domain/bloc/weather_state.dart';
import 'package:weather_app/domain/use_cases/get_locations_usecase.dart'
    show GetLocationsUseCase;
import 'package:weather_app/domain/use_cases/get_weather_report_usecase.dart'
    show GetWeatherReportUseCase;
import 'package:weather_app/helper/text_helper.dart';
import 'package:weather_app/helper/utils.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetLocationsUseCase getLocationsUseCase;
  final GetWeatherReportUseCase getWeatherReportUseCase;
  WeatherBloc({
    required this.getLocationsUseCase,
    required this.getWeatherReportUseCase,
  }) : super(WeatherState()) {
    on<GetLocationsEvent>((event, emit) async {
      try {
        emit(state.copyWith(getLocationsStatus: ProgressStatus.loading));
        final result = await getLocationsUseCase.call(event.query);
        if (result.success) {
          emit(
            state.copyWith(
              getLocationsStatus: ProgressStatus.success,
              locations: result.data,
            ),
          );
        } else {
          emit(
            state.copyWith(
              getLocationsStatus: ProgressStatus.failure,
              errorMessage: TextHelper.locationNotFound,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            getLocationsStatus: ProgressStatus.failure,
            errorMessage: TextHelper.locationNotFound,
          ),
        );
      }
    });

    on<GetWeatherEvent>((event, emit) async {
      try {
        emit(state.copyWith(getWeatherStatus: ProgressStatus.loading));
        final result = await getWeatherReportUseCase.call(
          latitude: event.latitude,
          longitude: event.longitude,
        );
        if (result.success) {
          final selectedDayIndex = getTodayIndex(result.data?.daily.time ?? []);
          emit(
            state.copyWith(
              getWeatherStatus: ProgressStatus.success,
              weather: result.data,
              selectedDay: selectedDayIndex,
            ),
          );
        } else {
          emit(
            state.copyWith(
              getWeatherStatus: ProgressStatus.failure,
              errorMessage: result.message,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            getWeatherStatus: ProgressStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<SetSelectedDayEvent>((event, emit) {
      emit(state.copyWith(selectedDay: event.dayIndex));
    });
  }

  int getTodayIndex(List<int> forecastUnixList) {
    final today = DateTime.now();
    for (int i = 0; i < forecastUnixList.length; i++) {
      final forecastDate = convertUnixToIST(forecastUnixList[i]);
      if (forecastDate.day == today.day &&
          forecastDate.month == today.month &&
          forecastDate.year == today.year) {
        return i;
      }
    }
    return 0;
  }
}
