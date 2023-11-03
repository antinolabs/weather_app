import 'package:dummy/features/weather_Forcast/view/weather_forecast_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<FirebasePhoneAuthHelper, FirebasePhoneAuthState>
    firebasePhoneAuthHelper =
    StateNotifierProvider((ref) => FirebasePhoneAuthHelper());

class FirebasePhoneAuthState {
  final String? verificationId;
  final bool otpSent;

  FirebasePhoneAuthState({
    required this.verificationId,
    required this.otpSent,
  });
}

class FirebasePhoneAuthHelper extends StateNotifier<FirebasePhoneAuthState> {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebasePhoneAuthHelper()
      : super(FirebasePhoneAuthState(verificationId: null, otpSent: false));

  void intUserStream(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // Handleer for userlogout
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const WeatherForeCastView(),
        ));
      }
    });
  }

  Future<void> sendOtpRequest(BuildContext context,
      {String? phoneNumber}) async {
    state = FirebasePhoneAuthState(verificationId: null, otpSent: false);
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        timeout: const Duration(seconds: 50),
        verificationFailed: (FirebaseAuthException e) {
          state = FirebasePhoneAuthState(verificationId: null, otpSent: false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('OTP failed to send. Please check the number.'),
          ));
        },
        codeSent: (String verifyId, int? forceResendingToken) {
          state =
              FirebasePhoneAuthState(verificationId: verifyId, otpSent: true);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('OTP sent'),
          ));
        },
        codeAutoRetrievalTimeout: (String verifyId) {
          state =
              FirebasePhoneAuthState(verificationId: verifyId, otpSent: true);
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      );
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> verifyOTP({String? otp, required BuildContext context}) async {
    if (state.verificationId != null && otp != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId ?? '',
        smsCode: otp,
      );

      await auth.signInWithCredential(credential).then((value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const WeatherForeCastView(),
        ));
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('OTP invalid'),
        ));
      });
    }
  }
}
