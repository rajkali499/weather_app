import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data/model/weather_forecast_response.dart';
import 'package:weather_app/data/offline_storage/location_preference.dart';
import 'package:weather_app/domain/bloc/get_weather_event.dart';
import 'package:weather_app/domain/bloc/set_selected_day_event.dart';
import 'package:weather_app/domain/bloc/weather_bloc.dart';
import 'package:weather_app/domain/bloc/weather_state.dart';
import 'package:weather_app/helper/colors.dart';
import 'package:weather_app/helper/dialog_helper.dart';
import 'package:weather_app/helper/text_helper.dart';
import 'package:weather_app/helper/utils.dart';
import 'package:weather_app/helper/weather_condition_utils.dart';
import 'package:weather_app/view/widgets/lottie_loader.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: const Color(0xFF2C3440),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state.getWeatherStatus == ProgressStatus.failure) {
            showSnackBar(
              context,
              state.errorMessage ?? "",
              isError: true,
              isSuccess: false,
            );
          }
        },
        builder: (context, state) {
          if (state.getWeatherStatus == ProgressStatus.loading) {
            return const LottieLoader();
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: isMobile
                  ? Column(
                      children: [
                        Expanded(child: _buildLeftCard(context, state)),
                        const SizedBox(height: 16),
                        _buildRightCard(
                          context,
                          state.weather,
                          state.selectedDay,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: _buildLeftCard(context, state)),
                        const SizedBox(width: 16),
                        _buildRightCard(
                          context,
                          state.weather,
                          state.selectedDay,
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeftCard(BuildContext context, WeatherState state) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [ColorHelper.blue, ColorHelper.primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getWeekdayName(
                  convertUnixToIST(
                    state.weather?.daily.time[state.selectedDay] ?? 0,
                  ),
                ),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                formatDate(
                  convertUnixToIST(
                    state.weather?.daily.time[state.selectedDay] ?? 0,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '${selectedLocation?.name}, ${selectedLocation?.country}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Spacer(flex: 5),
              Text(
                "${wmoWeatherMap[state.weather?.daily.weatherCode[state.selectedDay] ?? 0]?.emoji}",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${state.weather?.daily.temperature2mMin[state.selectedDay] ?? 29} ${state.weather?.dailyUnits.temperature2mMin}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${wmoWeatherMap[state.weather?.daily.weatherCode[state.selectedDay] ?? 0]?.emoji} ${wmoWeatherMap[state.weather?.daily.weatherCode[state.selectedDay] ?? 0]?.description}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        
        Lottie.asset(
          wmoWeatherMap[state.weather?.daily.weatherCode[state.selectedDay] ?? 0]?.icon ?? "",
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildRightCard(
    BuildContext context,
    WeatherForecastResponse? weather,
    int selectedDay,
  ) {
    return Container(
      // width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorHelper.weatherCardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextHelper.precipitation,
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                " ${weather?.daily.precipitationSum[selectedDay] ?? 0} ${weather?.dailyUnits.precipitationSum}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextHelper.humidity,
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                " ${weather?.daily.relativeHumidity2mMin[selectedDay] ?? 0} ${weather?.dailyUnits.relativeHumidity2mMin}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(TextHelper.wind, style: TextStyle(color: Colors.white70)),
              Text(
                " ${weather?.daily.windSpeed10mMax[selectedDay] ?? 0} ${weather?.dailyUnits.windSpeed10mMax}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: weather?.daily.time.length ?? 0,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _buildForecastCard(
                  getWeekdayName(
                    convertUnixToIST(weather?.daily.time[index] ?? 0),
                  ),
                  weather?.daily.weatherCode[index] ?? 0,
                  "${weather?.daily.temperature2mMin[index] ?? 0} ${weather?.dailyUnits.temperature2mMin}",
                  isSelected: index == selectedDay,
                  onTap: () {
                    context.read<WeatherBloc>().add(SetSelectedDayEvent(index));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [ColorHelper.blue, ColorHelper.primaryColor],
              ),
            ),
            child: TextButton.icon(
              onPressed: () {
                showLocationSearchDialog(
                  context,
                  onLocationSelected: (location) {
                    selectedLocation = location;
                    context.read<WeatherBloc>().add(
                      GetWeatherEvent(
                        latitude: location.latitude,
                        longitude: location.longitude,
                      ),
                    );
                    LocationPrefs.saveLastLocation(location);
                  },
                );
              },
              icon: const Icon(Icons.location_pin, color: Colors.white),
              label: Text(
                TextHelper.changeLocation,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastCard(
    String day,
    int weatherCode,
    String temp, {
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              wmoWeatherMap[weatherCode]?.emoji ?? '',
              style: TextStyle(
                fontSize: 25,
                color: isSelected ? ColorHelper.black : ColorHelper.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              day.substring(0, 3),
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? ColorHelper.black : ColorHelper.white,
              ),
            ),
            Text(
              temp,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isSelected ? ColorHelper.black : ColorHelper.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

 }
