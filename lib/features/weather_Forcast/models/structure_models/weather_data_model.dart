class WeatherDataModel {
  final String weatherStatus;
  final int temperature;
  final int humidity;
  final int windSpeed;
  final String cityName;

  WeatherDataModel({
    required this.weatherStatus,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.cityName
  });
  factory WeatherDataModel.empty() {
    return WeatherDataModel(
      weatherStatus: '',
      temperature: 0,
      humidity: 0,
      windSpeed: 0,
      cityName: '',
    );
  }

}
