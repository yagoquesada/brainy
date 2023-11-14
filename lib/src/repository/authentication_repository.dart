import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tfg_v3/src/features/authentication/landing/landing_screen.dart';
import 'package:tfg_v3/src/features/authentication/mail_verification/mail_verification.dart';

import 'package:tfg_v3/src/features/menu/menu_screen.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/repository/exceptions.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class YAuthenticationRepository extends GetxController {
  static YAuthenticationRepository get instance => Get.find();

  /// Variables
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  // late final GoogleSignInAccount _googleUser;

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => firebaseUser?.uid ?? '';

  String get getUserEmail => firebaseUser?.email ?? '';

  /// Loads when app Launch from main.dart
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
    // ever(_firebaseUser, setInitialScreen);
  }

  /// Setting initial screen
  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LandingScreen())
        : user.emailVerified
            ? Get.offAll(() => const MenuScreen())
            : Get.offAll(() => const MailVerification());
  }

  /* -------------- Email & Passoword sign-in-up -------------- */

  /// [EmailAuthentication] - REGISTER
  Future<void> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firebaseUser.value != null
          ? Get.offAll(() => const MenuScreen())
          : Get.to(() => const LandingScreen());

      firebaseUser!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [EmailAuthentication] - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [EmailVerification] - VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /* -------------- Federated Identify & Social sign-in -------------- */

  /// [GoogleAuthentication]
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [FacebookAuthentication]
  Future<void> signInWithFacebook() async {}

  /* -------------- Account settings -------------- */

  /// [LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      // await FacebookAuth.instance.singOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LandingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [ResetPassword]
  Future<void> sendPasswordResetToEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then(
        (value) {
          getSnackBar(
            YTexts.tSuccess,
            YTexts.tResetPasswordMsg,
            false,
          );
          logout();
        },
      );
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [DeleteAccount]
  Future<void> deleteUserAccount(String email, String password) async {
    try {
      User? user = _auth.currentUser;

      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      await user!.reauthenticateWithCredential(credential).then(
        (value) {
          value.user!.delete().then(
            (res) {
              getSnackBar(
                YTexts.tSuccess,
                YTexts.tAccountDeleted,
                false,
              );
            },
          );
        },
      );
      Get.offAll(() => const LandingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [GoogleAuthentication] - DISCONNECT ACCOUNT
  Future<void> deleteGoogleAccount() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.delete().then(
        (res) {
          getSnackBar(
            YTexts.tSuccess,
            YTexts.tAccountDeleted,
            false,
          );
        },
      );
      Get.offAll(() => const LandingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }

  /// [UpdateName]
  Future<void> updateDisplayName(String name) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      user.updateDisplayName(name);
      Get.offAll(() => const MenuScreen());
    } on FirebaseAuthException catch (e) {
      final ex = YExceptions.code(e.code);
      throw ex.message;
    } on SocketException catch (e) {
      throw e.message;
    } catch (_) {
      const ex = YExceptions();
      throw ex.message;
    }
  }
}
