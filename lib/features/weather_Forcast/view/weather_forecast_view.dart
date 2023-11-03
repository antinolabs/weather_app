import 'package:dummy/core/utilities/Image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../component_widgets/weather_forecast_molecular_widgets.dart';
import '../model_view/weather_forecast_provider.dart';

class WeatherForeCastView extends ConsumerStatefulWidget {
  const WeatherForeCastView({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherForeCastView> createState() =>
      _MainWeatherReportScreenState();
}

class _MainWeatherReportScreenState
    extends ConsumerState<WeatherForeCastView> {
  @override
  void initState() {
    final notifier = ref.read(weatherNotifierProvider.notifier);
    notifier.fetchWeather("new delhi");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final weatherState = ref.watch(weatherNotifierProvider);
            if (weatherState.weatherData != null) {
              // Access and use weatherState.weatherData
              final weatherData = weatherState.weatherData!;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SearchScreen(),
                    const SizedBox(height: 70),
                    const WeatherDisplayWidget(),
                    const SizedBox(
                      height: 50,
                    ),
                    TemperatureWidget(
                        color: Theme.of(context).primaryColorDark),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            } else {
              // Handle the case where data is not available
              return Center(
                child: Lottie.asset(ImagePath.lottieLoader),
              );
            }
          },
        ),
      ),
    );
  }
}
