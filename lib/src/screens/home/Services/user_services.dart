import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackit/src/comman/showsnackbar.dart';
import 'package:trackit/src/models/user_model.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// By Stream
  Stream<UserModel?> getUserDataStream(String uid) {
    User? user = _auth.currentUser;

    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return UserModel.fromMap(snapshot.data()!);
        } else {
          SnackbarHelper.showSnackbar(
            title: "Error",
            message: "User data not found.",
            isError: true,
          );
          return null;
        }
      });
    } else {
      return Stream.value(null);
    }
  }

// By Future

  // Future<UserModel?> getUserData() async {
  //   try {
  //     User? user = _auth.currentUser;

  //     if (user != null) {
  //       DocumentSnapshot<Map<String, dynamic>> userDoc =
  //           await _firestore.collection('users').doc(user.uid).get();

  //       if (userDoc.exists) {
  //         return UserModel.fromMap(userDoc.data()!);
  //       } else {
  //         SnackbarHelper.showSnackbar(
  //           title: "Error",
  //           message: "User data not found.",
  //           isError: true,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     SnackbarHelper.showSnackbar(
  //       title: "Error",
  //       message: "Failed to fetch user data.",
  //       isError: true,
  //     );
  //   }
  //   return null;
  // }

  Future<void> updateBalance(double newBalance) async {
    try {
      final userId = _auth.currentUser!.uid;

      await _firestore
          .collection('users')
          .doc(userId)
          .update({"balance": newBalance});
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: "Failed to update balance.",
        isError: true,
      );
    }
  }
}
