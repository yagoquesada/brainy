import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/repository/authentication_repository.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class MailVerificationController extends GetxController {
  // ignore: unused_field
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }

  /// -- Send or Resend Email Verification
  void sendVerificationEmail() async {
    try {
      await YAuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      getSnackBar(
        YTexts.tSnap,
        e.toString(),
        true,
      );
    }
  }

  /// -- Set Timer to check if Verification Completed then Redirect
  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        YAuthenticationRepository.instance.setInitialScreen(user);
      }
    });
  }

  /// -- Manually check if Verification Completed then Redirect
  void manuallyCheckEmailVerificationStatus() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      YAuthenticationRepository.instance.setInitialScreen(user);
    }
  }
}
