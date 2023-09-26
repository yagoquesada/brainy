class EmailVerificationFailure {
  final String message;

  const EmailVerificationFailure(
      [this.message = "Unknow error please try again later or try to restore your password."]);

  factory EmailVerificationFailure.code(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const EmailVerificationFailure('Email already exists.');
      case 'invalid-email':
        return const EmailVerificationFailure('Email is not valid or badly formatted');
      case 'weak-password':
        return const EmailVerificationFailure('Please enter a stronger password.');
      case 'user-disabled':
        return const EmailVerificationFailure('The user corresponding to the given email has been disabled.');
      case 'user-not-found':
        return const EmailVerificationFailure('No user found for that email.');

      default:
        return const EmailVerificationFailure();
    }
  }
}
