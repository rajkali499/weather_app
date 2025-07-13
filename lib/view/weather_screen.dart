import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/data/model/weather_forecast_response.dart';
import 'package:weather_app/domain/bloc/get_locations_event.dart';
import 'package:weather_app/domain/bloc/get_weather_event.dart';
import 'package:weather_app/domain/bloc/weather_bloc.dart';
import 'package:weather_app/domain/bloc/weather_state.dart';
import 'package:weather_app/helper/colors.dart';
import 'package:weather_app/helper/dialog_helper.dart';
import 'package:weather_app/helper/text_helper.dart';
import 'package:weather_app/helper/utils.dart';
import 'package:weather_app/helper/weather_condition_utils.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

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
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isMobile
                  ? Column(
                      children: [
                        Expanded(child: _buildLeftCard(context, state)),
                        const SizedBox(height: 16),
                        _buildRightCard(context, state.weather),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLeftCard(context, state),
                        const SizedBox(width: 16),
                        _buildRightCard(context, state.weather),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeftCard(BuildContext context, WeatherState state) {
    print("object");
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [ColorHelper.blue, ColorHelper.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // image: DecorationImage(
        //   image: AssetImage('assets/beach.jpg'), // Use your image
        //   fit: BoxFit.cover,
        //   colorFilter: ColorFilter.mode(
        //     Colors.black.withOpacity(0.3),
        //     BlendMode.darken,
        //   ),
        // ),
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
                '${selectedLocation?.name}, ${selectedLocation?.country}' ??
                    "Biarritz, FR",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.wb_sunny, color: Colors.white, size: 48),
          SizedBox(height: 8),
          Text(
            "${state.weather?.daily.temperature2mMax[state.selectedDay] ?? 29} ${state.weather?.dailyUnits.temperature2mMax}",
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
    );
  }

  Widget _buildRightCard(
    BuildContext context,
    WeatherForecastResponse? weather,
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PRECIPITATION", style: TextStyle(color: Colors.white70)),
              Text("0%", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("HUMIDITY", style: TextStyle(color: Colors.white70)),
              Text("42%", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("WIND", style: TextStyle(color: Colors.white70)),
              Text("3 km/h", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildForecastCard(
                "Tue",
                Icons.wb_sunny,
                "30 °C",
                isSelected: true,
              ),
              _buildForecastCard("Wed", Icons.cloud, "22 °C"),
              _buildForecastCard("Thu", Icons.cloudy_snowing, "06 °C"),
              _buildForecastCard("Fri", Icons.wb_sunny_outlined, "26 °C"),
            ],
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
                  },
                );
              },
              icon: const Icon(Icons.location_pin, color: Colors.white),
              label: const Text(
                "Change Location",
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
    IconData icon,
    String temp, {
    bool isSelected = false,
  }) {
    return Container(
      width: 56,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? ColorHelper.black : ColorHelper.white,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            day,
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
    );
  }

  Future<void> showLocationSearchDialog(
    BuildContext context, {
    required Function(LocationModel location) onLocationSelected,
  }) {
    TextEditingController searchController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        Set<LocationModel> filtered = <LocationModel>{};
        bool isLoading = false;

        return BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.getLocationsStatus == ProgressStatus.loading) {
              isLoading = true;
            } else if (state.getLocationsStatus == ProgressStatus.failure) {
              isLoading = false;
              showSnackBar(
                context,
                state.errorMessage ?? TextHelper.failedToLoadLocations,
                isSuccess: false,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            if (state.getLocationsStatus == ProgressStatus.success) {
              isLoading = false;
              filtered = state.locations?.results.toSet() ?? <LocationModel>{};
            }
            return Dialog(
              backgroundColor: const Color(0xFF0E1117),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 450,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextHelper.searchLocations,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: searchController,
                        onChanged: (value) async {
                          context.read<WeatherBloc>().add(
                            GetLocationsEvent(query: value),
                          );
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF1C1F26),
                          hintText: TextHelper.searchHintText,
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        TextHelper.recentLocations,
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: isLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: ColorHelper.blue,
                                    strokeWidth: 5,
                                  ),
                                ),
                              )
                            : filtered.isEmpty
                            ? Center(
                                child: Text(
                                  TextHelper.noResults,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final loc = filtered.elementAt(index);
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color:
                                          ColorHelper.dialogLocationCardColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        onLocationSelected(loc);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            loc.countryCode ?? '',
                                            style: TextStyle(fontSize: 20),
                                          ), // optional flag
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  loc.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${loc.country}, ${loc.admin1} (${loc.latitude.toStringAsFixed(2)}°N ${loc.longitude.toStringAsFixed(2)}°E ${loc.elevation?.toStringAsFixed(0)}m asl)',
                                                  style: const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
