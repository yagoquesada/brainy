import '../../../core/presentation/utils/constants/text_strings.dart';

class EmailVerificationFailure {
  final String message;

  const EmailVerificationFailure([this.message = YTexts.unknownError]);

  factory EmailVerificationFailure.code(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const EmailVerificationFailure(YTexts.emailInUse);
      case 'invalid-email':
        return const EmailVerificationFailure(YTexts.invalidEmail);
      case 'weak-password':
        return const EmailVerificationFailure(YTexts.weakPassword);
      case 'user-disabled':
        return const EmailVerificationFailure(YTexts.userDisabled);
      case 'user-not-found':
        return const EmailVerificationFailure(YTexts.userNotFound);

      default:
        return const EmailVerificationFailure();
    }
  }
}
