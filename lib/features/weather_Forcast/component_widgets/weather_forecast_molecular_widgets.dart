import 'package:dummy/core/utilities/Image_path.dart';
import 'package:dummy/core/utilities/app_color.dart';
import 'package:dummy/features/weather_Forcast/services_functions/helper_service_functions.dart';
import 'package:dummy/features/weather_Forcast/component_widgets/weather_forcast_atoms_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../authentication /view_model/firebase_authentication.dart';
import '../model_view/weather_forecast_provider.dart';

class WeatherDisplayWidget extends StatelessWidget {
  const WeatherDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final weatherState = ref.watch(weatherNotifierProvider);
      return Column(
        children: [
          lottieLoaderFunction(
              weatherCondition: weatherState.weatherData!.weatherStatus),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Text(
                  "${weatherState.weatherData?.temperature}º",
                  style: const TextStyle(
                    fontSize: 64,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${weatherState.weatherData?.cityName}\n",
                        style: const TextStyle(
                          fontSize: 44,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: weatherState.weatherData?.weatherStatus,
                        style: const TextStyle(
                          // Slightly adjust the position to the left
                          fontSize: 18,
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          textBaseline: TextBaseline.alphabetic,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class TemperatureWidget extends ConsumerWidget {
  final double width;
  final double height;
  final Color color;

  TemperatureWidget({
    Key? key,
    this.width = 343,
    this.height = 47,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final weatherState = ref.watch(weatherNotifierProvider);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChipContentWidget(
            imagePath: ImagePath.rainDrops,
            text: "${weatherState.weatherData?.temperature}º",
          ),
          ChipContentWidget(
            imagePath: ImagePath.humidityMeter,
            text: "${weatherState.weatherData?.humidity}%",
          ),
          ChipContentWidget(
            imagePath: ImagePath.windMeter,
            text: "${weatherState.weatherData?.windSpeed} km/h",
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    // Handle the search action here.
    String query = _searchController.text;
    ref.read(weatherNotifierProvider.notifier).fetchWeather(query);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(color: AppColors.white),
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search your city..',
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                onPressed: _onSearch,
                icon: const Icon(Icons.search, color: AppColors.white),
              ),
            ),
          ),
          // Display search results here.
        ],
      ),
    );
  }
}

class AuthTextFieldCard extends ConsumerStatefulWidget {
  const AuthTextFieldCard({Key? key}) : super(key: key);

  @override
  _AuthTextFieldCardState createState() => _AuthTextFieldCardState();
}

class _AuthTextFieldCardState extends ConsumerState<AuthTextFieldCard> {
  @override
  Widget build(BuildContext context) {
    final authProvider = ref.read(firebasePhoneAuthHelper.notifier);
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController otpController = TextEditingController();

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: AppColors.white),
          ),
          style: const TextStyle(color: AppColors.white),
          keyboardType: TextInputType.number,
          controller: phoneNumberController,
        ),
        // OTP TextField
        TextField(
          decoration: const InputDecoration(
            labelText: 'OTP',
            labelStyle: TextStyle(color: AppColors.white),
          ),
          style: const TextStyle(color: AppColors.white),
          keyboardType: TextInputType.number,
          controller: otpController,
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              if (authProvider.state.otpSent) {
                authProvider.verifyOTP(
                    context: context, otp: otpController.text);
              } else {
                authProvider.sendOtpRequest(context,
                    phoneNumber: phoneNumberController.text);
              }
            },
            child: const Text('Verify OTP',
                style: TextStyle(color: AppColors.white)),
          ),
        ),
      ],
    );
  }
}

/////TODO put all the images and lotties to a single clase///////
/////Todo put the api key to one place//////
