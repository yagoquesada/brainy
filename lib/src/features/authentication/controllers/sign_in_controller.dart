import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tfg_v3/src/repository/authentication_repository/authentication_repository.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  /// TextField Controllers to get data from `TextFields`
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  /// [EmailAndPasswordLogin]
  Future<void> loginUser() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isLoading.value = false;
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }

  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }

  /// [FacebookSignInAuthentication]
}
