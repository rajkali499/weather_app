import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/remote_data_source/weather_remote_datasource.dart';
import 'package:weather_app/domain/bloc/weather_bloc.dart' show WeatherBloc;
import 'package:weather_app/domain/use_cases/get_locations_usecase.dart';
import 'package:weather_app/domain/use_cases/get_weather_report_usecase.dart';
import 'package:weather_app/helper/colors.dart';
import 'package:weather_app/helper/text_helper.dart';
import 'package:weather_app/view/weather_screen.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WeatherWidget());
  }
}
