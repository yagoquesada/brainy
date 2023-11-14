import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class EmailVerificationFailure {
  final String message;

  const EmailVerificationFailure([this.message = YTexts.tUnknownError]);

  factory EmailVerificationFailure.code(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const EmailVerificationFailure(YTexts.tEmailInUse);
      case 'invalid-email':
        return const EmailVerificationFailure(YTexts.tInvalidEmail);
      case 'weak-password':
        return const EmailVerificationFailure(YTexts.tWeakPassword);
      case 'user-disabled':
        return const EmailVerificationFailure(YTexts.tUserDisabled);
      case 'user-not-found':
        return const EmailVerificationFailure(YTexts.tUserNotFound);

      default:
        return const EmailVerificationFailure();
    }
  }
}
