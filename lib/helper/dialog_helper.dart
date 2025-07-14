import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/domain/bloc/get_locations_event.dart';
import 'package:weather_app/domain/bloc/weather_bloc.dart';
import 'package:weather_app/domain/bloc/weather_state.dart';
import 'package:weather_app/helper/colors.dart';
import 'package:weather_app/helper/text_helper.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  bool isSuccess = true,
  bool isWarning = false,
  bool isError = false,
}) {
  String icon = isSuccess
      ? '✅'
      : isWarning
      ? '⚠️'
      : isError
      ? '❌'
      : '';

  Fluttertoast.showToast(
    msg: "$icon  $message",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isSuccess
        ? Colors.green
        : isError
        ? Colors.red
        : Colors.orange,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}

 Future<void> showLocationSearchDialog(
    BuildContext context, {
    required Function(LocationModel location) onLocationSelected,
    Timer? debounce,
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
              filtered = state.locations?.results?.toSet() ?? <LocationModel>{};
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
                        onChanged: (value) {
                          if (debounce?.isActive ?? false) debounce!.cancel();
                          debounce = Timer(
                            const Duration(milliseconds: 500),
                            () {
                              if (value.trim().isNotEmpty) {
                                context.read<WeatherBloc>().add(
                                  GetLocationsEvent(query: value.trim()),
                                );
                              }
                            },
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
                                                  '${loc.country}, ${loc.admin1 ?? ''} (${loc.latitude.toStringAsFixed(2)}°N ${loc.longitude.toStringAsFixed(2)}°E ${loc.elevation?.toStringAsFixed(0)}m asl)',
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

