import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/app/authentication/repositories/authentication_repository.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  /// TextField Controllers to get data from `TextFields`
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  /// [EmailPasswordFullNameRegister]
  Future<void> registerUser() async {
    try {
      isLoading.value = true;
      if (!registerFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = YAuthenticationRepository.instance;
      await auth.createUserWithEmailAndPassword(email.text.trim(), password.text.trim(), fullName.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isLoading.value = false;
      getSnackBar(
        YTexts.snap,
        e.toString(),
        true,
      );
    }
  }

  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = YAuthenticationRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      getSnackBar(
        YTexts.snap,
        e.toString(),
        true,
      );
    }
  }

  /// [FacebookSignInAuthentication]
}
