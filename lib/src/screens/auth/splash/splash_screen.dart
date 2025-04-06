import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDark = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            duration: Duration(milliseconds: 2000),
            opacity: splashController.animate.value ? 1 : 0,
            child: Text(
              'TrackIt',
              style: GoogleFonts.bebasNeue(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: isDark ? dPrimaryColor : dSecondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
