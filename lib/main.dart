import 'package:dummy/core/utilities/app_color.dart';
import 'package:dummy/features/authentication%20/view/log_in_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/weather_Forcast/view/weather_forecast_view.dart';
import 'core/core_services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        primaryColorDark: AppColors.primaryInner,
        useMaterial3: true,
      ),
      home: const LogInView(),
    );
  }
}

class MainRootWidget extends StatelessWidget {
  const MainRootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherForeCastView();
  }
}
