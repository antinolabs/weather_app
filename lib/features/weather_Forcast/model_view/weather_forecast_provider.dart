import 'dart:developer';
import 'package:dummy/features/weather_Forcast/models/repositories/weather_forecast_repo.dart';
import 'package:dummy/features/weather_Forcast/models/structure_models/weather_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier();
});

class WeatherState {
  final WeatherDataModel? weatherData;

  WeatherState({required this.weatherData});
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState(weatherData: null));

  Future<void> fetchWeather( String location) async {
    try {
      final weatherData =
          await WeatherForecastRepo().fetchWeatherData(location);
      WeatherDataModel weatherDataModel = WeatherDataModel(
          weatherStatus: weatherData["weatherStatus"],
          temperature: weatherData["temperature"],
          humidity: weatherData["humidity"],
          windSpeed: weatherData["windSpeed"],
          cityName: weatherData["cityName"]);
      state = WeatherState(weatherData: weatherDataModel);
    } catch (e) {
      log('Failed to fetch weather data: $e');
    }
  }
}
