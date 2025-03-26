import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/signup_controller.dart';
import 'package:trackit/src/screens/auth/login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final signupController = Get.put(SignupController());
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
              SizedBox(height: 3),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/signup.png",
                  height: screenHeignt / 3.3,
                ),
              ),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.left,
                "Signup".toUpperCase(),
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                textAlign: TextAlign.left,
                "Sign up to unlock all the amazing features!",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: signupController.namecontroller,
                      style:
                          theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        label: Text(
                          "Name",
                          style: theme.textTheme.bodyLarge,
                        ),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: signupController.emailcontroller,
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
                          return "Please Enter Email";
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => TextFormField(
                        controller: signupController.passwordcontroller,
                        obscureText: signupController.isSecure.value,
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
                              signupController.isVisible();
                            },
                            icon: Icon(signupController.isSecure.value
                                ? Icons.remove_red_eye_outlined
                                : Icons.lock_outlined),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: signupController.isLoading.value
                                ? null
                                : () {
                                    if (_formkey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      signupController.signupUser(
                                        signupController.namecontroller.text
                                            .trim(),
                                        signupController.emailcontroller.text
                                            .trim(),
                                        signupController.passwordcontroller.text
                                            .trim(),
                                      );
                                    }
                                  },
                            child: signupController.isLoading.value
                                ? CircularProgressIndicator(
                                    color: isDark
                                        ? dPrimaryColor
                                        : dSecondaryColor,
                                  )
                                : Text(
                                    "Signup".toUpperCase(),
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: isDark
                                          ? dSecondaryColor
                                          : dPrimaryColor,
                                    ),
                                  )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(LoginScreen()),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account?",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: " Login",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue),
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
