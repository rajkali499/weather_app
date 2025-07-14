import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/data/offline_storage/location_preference.dart';
import 'package:weather_app/data/remote_data_source/weather_remote_datasource.dart';
import 'package:weather_app/domain/bloc/get_weather_event.dart';
import 'package:weather_app/domain/bloc/weather_bloc.dart' show WeatherBloc;
import 'package:weather_app/domain/use_cases/get_locations_usecase.dart';
import 'package:weather_app/domain/use_cases/get_weather_report_usecase.dart';
import 'package:weather_app/helper/colors.dart';
import 'package:weather_app/helper/dialog_helper.dart';
import 'package:weather_app/helper/text_helper.dart';
import 'package:weather_app/helper/utils.dart';
import 'package:weather_app/view/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocationPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(
        getLocationsUseCase: GetLocationsUseCase(
          remoteDataSource: WeatherRemoteDataSourceImpl(),
        ),
        getWeatherReportUseCase: GetWeatherReportUseCase(
          remoteDataSource: WeatherRemoteDataSourceImpl(),
        ),
      ),
      child: MaterialApp(
        title: TextHelper.appName,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: ColorHelper.primaryColor),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  class _MyHomePageState extends State<MyHomePage> {
  bool _showLocationPrompt = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final location = await LocationPrefs.loadLastLocation();
    if (location != null) {
      selectedLocation = location;
      context.read<WeatherBloc>().add(
        GetWeatherEvent(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );
    } else {
      // Trigger location prompt
      setState(() {
        _showLocationPrompt = true;
      });
    }
  }

  void _onLocationSelected(LocationModel location) {
    selectedLocation = location;
    LocationPrefs.saveLastLocation(location);
    context.read<WeatherBloc>().add(
      GetWeatherEvent(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
    setState(() {
      _showLocationPrompt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const WeatherWidget(), // main weather screen

        if (_showLocationPrompt)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  alignment: Alignment.center,
                  child: _buildLocationPromptDialog(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLocationPromptDialog() {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.2),
              Colors.white.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
             TextHelper.welcomeText,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              TextHelper.locationPromptText,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [ColorHelper.blue, ColorHelper.primaryColor],
              ),
            ),
              child: TextButton.icon(
                icon: const Icon(Icons.location_on, color: Colors.white),
                label: Text(TextHelper.selectLocation, style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showLocationSearchDialog(
                    context,
                    onLocationSelected: _onLocationSelected,
                    debounce:  _debounce, 
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
