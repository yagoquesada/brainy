class Exceptions {
  final String message;

  const Exceptions([this.message = "Unknow error please try again later or try to restore your password. "]);

  factory Exceptions.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const Exceptions('No user found for that email.');
      case 'wrong-password':
        return const Exceptions('Incorrect password, please try again.');
      case 'invalid-email':
        return const Exceptions('The email adress is not valid.');
      case 'user-disabled':
        return const Exceptions('This user has been disabled.');
      case 'weak-password':
        return const Exceptions('Please enter a stronger password.');
      case 'email-already-in-use':
        return const Exceptions('An account already exists for that email.');
      case 'too-many-requests':
        return const Exceptions('Too many requests, service temporarily blocked.');
      case 'invalid-arguments':
        return const Exceptions('An invalid argument was provided to an Authentication method.');
      case 'invalid-password':
        return const Exceptions('Incorrect password, please try again.');
      case 'invalid-phone-number':
        return const Exceptions('The provided phone number is invalid.');
      case 'operation-not-allowed':
        return const Exceptions('Operation is not allowed.');
      case 'session-cookie-expired':
        return const Exceptions('The provided Firebase session cookie is expired');
      case 'uid-already-exists':
        return const Exceptions('The provided uid is already in use by an existing user');
      default:
        return const Exceptions();
    }
  }
}
