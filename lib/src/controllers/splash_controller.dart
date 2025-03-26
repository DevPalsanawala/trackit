import 'package:get/get.dart';
import 'package:trackit/src/comman/streamcheck.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1200));
    animate.value = true;

    await Future.delayed(Duration(milliseconds: 5000));
    Get.off(Streamcheck());
  }
}
