import 'package:trackit/src/comman/showsnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorHandler {
  static String handleAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case "email-already-in-use":
        errorMessage = "This email is already registered.";
        break;
      case "weak-password":
        errorMessage = "Password is too weak. Please use a stronger password.";
        break;
      case "invalid-email":
        errorMessage = "Invalid email address.";
        break;
      case "user-not-found":
        errorMessage = "No user found with this email.";
        break;
      case "wrong-password":
        errorMessage = "Incorrect password.";
        break;
      default:
        errorMessage = "Authentication failed. Please try again.";
    }

    SnackbarHelper.showSnackbar(
      title: "Failed",
      message: errorMessage,
      isError: true,
    );
    return errorMessage;
  }
}
