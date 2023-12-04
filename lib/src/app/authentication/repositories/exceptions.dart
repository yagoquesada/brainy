import '../../../core/presentation/utils/constants/text_strings.dart';

class YExceptions {
  final String message;

  const YExceptions([this.message = YTexts.unknownError]);

  factory YExceptions.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const YExceptions(YTexts.wrongPassoword);
      case 'wrong-password':
        return const YExceptions(YTexts.wrongPassoword);
      case 'invalid-email':
        return const YExceptions(YTexts.invalidEmail);
      case 'user-disabled':
        return const YExceptions(YTexts.userDisabled);
      case 'weak-password':
        return const YExceptions(YTexts.weakPassword);
      case 'email-already-in-use':
        return const YExceptions(YTexts.emailInUse);
      case 'too-many-requests':
        return const YExceptions(YTexts.tooManyRequests);
      case 'invalid-arguments':
        return const YExceptions(YTexts.invalidArguments);
      case 'invalid-password':
        return const YExceptions(YTexts.invalidPassword);
      case 'invalid-phone-number':
        return const YExceptions(YTexts.invalidPhoneNumber);
      case 'operation-not-allowed':
        return const YExceptions(YTexts.operationNotAllowed);
      case 'session-cookie-expired':
        return const YExceptions(YTexts.sessionCookieExpired);
      case 'uid-already-exists':
        return const YExceptions(YTexts.uidAlreadyExists);
      default:
        return const YExceptions();
    }
  }
}
