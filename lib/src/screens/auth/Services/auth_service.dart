import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackit/src/comman/firebase_exception.dart';
import 'package:trackit/src/comman/showsnackbar.dart';
import 'package:trackit/src/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUser(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          createdAt: DateTime.now(),
          balance: 0,
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

        SnackbarHelper.showSnackbar(
            title: "Success", message: "Account created successfully.");
        return "success";
      }
      return "User creation failed";
    } on FirebaseAuthException catch (e) {
      return AuthErrorHandler.handleAuthError(e);
    } catch (e) {
      SnackbarHelper.showSnackbar(
          title: "Failed",
          message: "An unexpected error occurred.",
          isError: true);
      return "An unexpected error occurred.";
    }
  }

  Future<String> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      SnackbarHelper.showSnackbar(
          title: "Success", message: "Login successfully");
      return "success";
    } on FirebaseAuthException catch (e) {
      return AuthErrorHandler.handleAuthError(e);
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Failed",
        message: "An unexpected error occurred.",
        isError: true,
      );
      return "An unexpected error occurred.";
    }
  }
}
