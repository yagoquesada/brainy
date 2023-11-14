import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class YExceptions {
  final String message;

  const YExceptions([this.message = YTexts.tUnknownError]);

  factory YExceptions.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const YExceptions(YTexts.tWrongPassoword);
      case 'wrong-password':
        return const YExceptions(YTexts.tWrongPassoword);
      case 'invalid-email':
        return const YExceptions(YTexts.tInvalidEmail);
      case 'user-disabled':
        return const YExceptions(YTexts.tUserDisabled);
      case 'weak-password':
        return const YExceptions(YTexts.tWeakPassword);
      case 'email-already-in-use':
        return const YExceptions(YTexts.tEmailInUse);
      case 'too-many-requests':
        return const YExceptions(YTexts.tTooManyRequests);
      case 'invalid-arguments':
        return const YExceptions(YTexts.tInvalidArguments);
      case 'invalid-password':
        return const YExceptions(YTexts.tInvalidPassword);
      case 'invalid-phone-number':
        return const YExceptions(YTexts.tInvalidPhoneNumber);
      case 'operation-not-allowed':
        return const YExceptions(YTexts.tOperationNotAllowed);
      case 'session-cookie-expired':
        return const YExceptions(YTexts.tSessionCookieExpired);
      case 'uid-already-exists':
        return const YExceptions(YTexts.tUidAlreadyExists);
      default:
        return const YExceptions();
    }
  }
}
