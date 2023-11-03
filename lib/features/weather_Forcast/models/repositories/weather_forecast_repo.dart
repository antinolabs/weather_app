import 'package:dio/dio.dart';

class WeatherForecastRepo {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    final url =
        'http://api.weatherstack.com/current?access_key=3bc77609620eaa2322ff35d5fc6ecbdd&query=$location';
    //////was about to create a separate file for api routes but since its only one api so i directly gave the url link here to reduce the imports
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final current = data['current'];
        final location = data['location'];
        final weatherData = {
          'weatherStatus': current['weather_descriptions'][0],
          'temperature': current['temperature'],
          'humidity': current['humidity'],
          'windSpeed': current['wind_speed'],
          "cityName": location['name'],
        };
        return weatherData;
      } else if (response.statusCode == 601) {
        throw Exception('Please try a valid city name');
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
