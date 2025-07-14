import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/helper/asset_helper.dart';

class LottieLoader extends StatelessWidget {
  final double size;

  const LottieLoader({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Lottie.asset(
          AssetHelper.weatherIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
