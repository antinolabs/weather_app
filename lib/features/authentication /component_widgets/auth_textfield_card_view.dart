import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utilities/app_color.dart';
import '../view_model/firebase_authentication.dart';

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
