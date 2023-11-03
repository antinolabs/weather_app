import 'package:dummy/core/utilities/Image_path.dart';
import 'package:dummy/features/authentication%20/view_model/firebase_authentication.dart';
import 'package:dummy/features/weather_Forcast/component_widgets/weather_forecast_molecular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class LogInView extends ConsumerStatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInView> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInView> {
  late FirebasePhoneAuthHelper authProvider;

  @override
  void initState() {
    authProvider = ref.read(firebasePhoneAuthHelper.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                Lottie.asset(ImagePath.authenticationLottie),
                const SizedBox(height: 80),
                const AuthTextFieldCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
