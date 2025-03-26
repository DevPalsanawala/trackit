import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trackit/src/models/user_model.dart';
import 'package:trackit/src/screens/home/Services/user_services.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final UserServices _userservice = UserServices();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchUser();
    _listenToUserData();
  }

// By Future
  // Future<void> fetchUser() async {
  //   try {
  //     user.value = await _userservice.getUserData();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

// By Stream
  void _listenToUserData() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      _userservice.getUserDataStream(uid).listen((userData) {
        user.value = userData;
        isLoading.value = false;
      });
    }
  }

  Future<void> updateBalance(double amount, bool isIncome) async {
    if (user.value == null) return;

    double currentBalance = user.value!.balance;

    double newBalance =
        isIncome ? currentBalance + amount : currentBalance - amount;

    await _userservice.updateBalance(newBalance);

    // Update local user model for instant UI update
    user.value = user.value!.copyWith(balance: newBalance);
  }
}
