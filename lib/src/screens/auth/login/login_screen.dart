import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/login_controller.dart';
import 'package:trackit/src/screens/auth/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final logincontroller = Get.put(LoginController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDark = brightness == Brightness.dark;
    final screenHeignt = media.size.height;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/login.png",
                  height: screenHeignt / 3,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.left,
                "Login".toUpperCase(),
                style: theme.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                textAlign: TextAlign.left,
                "Welcome back! Please log in to continue.",
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: logincontroller.emailcontroller,
                      style:
                          theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        label: Text(
                          "Email",
                          style: theme.textTheme.bodyLarge,
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => TextFormField(
                        controller: logincontroller.passwordcontroller,
                        obscureText: logincontroller.isSecure.value,
                        style: theme.textTheme.headlineSmall!
                            .copyWith(fontSize: 20),
                        decoration: InputDecoration(
                          label: Text(
                            "Password",
                            style: theme.textTheme.bodyLarge,
                          ),
                          prefixIcon: Icon(Icons.fingerprint_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              logincontroller.isVisible();
                            },
                            icon: Icon(logincontroller.isSecure.value
                                ? Icons.remove_red_eye_outlined
                                : Icons.lock_outlined),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: logincontroller.isLoading.value
                              ? null
                              : () {
                                  if (_formkey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    logincontroller.loginUser(
                                      logincontroller.emailcontroller.text
                                          .trim(),
                                      logincontroller.passwordcontroller.text
                                          .trim(),
                                    );
                                  }
                                },
                          child: logincontroller.isLoading.value
                              ? CircularProgressIndicator(
                                  color:
                                      isDark ? dPrimaryColor : dSecondaryColor,
                                )
                              : Text(
                                  "Login".toUpperCase(),
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? dSecondaryColor
                                        : dPrimaryColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(SignupScreen()),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: " Signup",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
