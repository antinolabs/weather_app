import 'dart:async';
import 'package:dummy/core/utilities/Image_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum WeatherCondition {
  sunny,
  clear,
  overcast,
  mist,
  rainy,
}

Widget lottieLoaderFunction({required String weatherCondition}) {
  String lottieAsset;

  // Map the string condition to the enum
  switch (weatherCondition.toLowerCase()) {
    case 'sunny':
      lottieAsset = ImagePath.sunny;
      break;
    case 'clear':
      lottieAsset = ImagePath.clear;
      break;
    case 'overcast':
      lottieAsset = ImagePath.overCast;
      break;
    case 'cloudy':
      lottieAsset = ImagePath.cloudy;
      break;
    case 'rainy':
      lottieAsset = ImagePath.rainy;
      break;
    default:
    // Handle unknown condition
      lottieAsset = "assets/lotties/loader.json";
  }

  return Lottie.asset(
    lottieAsset,
    height: 207,
    width: 284,
  );
}
