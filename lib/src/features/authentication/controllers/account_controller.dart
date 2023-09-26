import 'package:get/get.dart';
import 'package:tfg_v3/src/repository/authentication_repository/authentication_repository.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();

  /// [ResetPassword]
  Future<void> resetPassword(String email) async {
    try {
      final auth = AuthenticationRepository.instance;
      auth.sendPasswordResetToEmail(email);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }

  /// [DeleteAccount]
  Future<void> deleteAccount(String email, String password) async {
    try {
      final auth = AuthenticationRepository.instance;
      auth.deleteUserAccount(email, password);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }

  /// [DisconnectGoogleAccount]
  Future<void> disconnectGoogle() async {
    try {
      final auth = AuthenticationRepository.instance;
      auth.deleteGoogleAccount();
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }

  /// [Logout]
  Future<void> logout() async {
    try {
      final auth = AuthenticationRepository.instance;
      auth.logout();
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }

  /// [UpdateDisplayName]
  Future<void> updateName(String name) async {
    try {
      final auth = AuthenticationRepository.instance;
      auth.updateDisplayName(name);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar("Oh Snap!", e.toString(), true);
    }
  }
}
