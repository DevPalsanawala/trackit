import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackit/firebase_options.dart';
import 'package:trackit/src/Theme/theme.dart';
import 'package:trackit/src/screens/auth/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackIt',
      theme: DAppTheme.lighttheme,
      darkTheme: DAppTheme.darktheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.cupertinoDialog,
      transitionDuration: Duration(milliseconds: 1000),
      home: SplashScreen(),
    );
  }
}
