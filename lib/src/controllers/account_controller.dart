import 'package:get/get.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/repository/authentication_repository.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();

  /// [ResetPassword]
  Future<void> resetPassword(String email) async {
    try {
      final auth = YAuthenticationRepository.instance;
      auth.sendPasswordResetToEmail(email);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar(
        YTexts.tSnap,
        e.toString(),
        true,
      );
    }
  }

  /// [DeleteAccount]
  Future<void> deleteAccount(String email, String password) async {
    try {
      final auth = YAuthenticationRepository.instance;
      auth.deleteUserAccount(email, password);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar(
        YTexts.tSnap,
        e.toString(),
        true,
      );
    }
  }

  /// [DisconnectGoogleAccount]
  Future<void> disconnectGoogle() async {
    try {
      final auth = YAuthenticationRepository.instance;
      auth.deleteGoogleAccount();
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar(
        YTexts.tSnap,
        e.toString(),
        true,
      );
    }
  }

  /// [Logout]
  Future<void> logout() async {
    try {
      final auth = YAuthenticationRepository.instance;
      auth.logout();
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar(
        YTexts.tSnap,
        e.toString(),
        true,
      );
    }
  }

  /// [UpdateDisplayName]
  Future<void> updateName(String name) async {
    try {
      final auth = YAuthenticationRepository.instance;
      auth.updateDisplayName(name);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      getSnackBar(
        YTexts.tSnap,
        e.toString(),
        true,
      );
    }
  }
}
