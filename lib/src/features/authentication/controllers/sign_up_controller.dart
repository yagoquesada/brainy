import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/repository/authentication_repository/authentication_repository.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

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
      final auth = AuthenticationRepository.instance;
      await auth.createUserWithEmailAndPassword(
          email.text.trim(), password.text.trim(), fullName.text.trim());
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
