import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/change_password_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

import 'ui/screens/sign_up_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
        ),
      ),
      initialRoute: '/',
      routes: {
        SplashScreen.name : (context) => SplashScreen(),
        SignInScreen.name: (context) => SignInScreen(),
        SignUpScreen.name: (context) => SignUpScreen(),
        ForgotPasswordEmailScreen.name:
            (context) => ForgotPasswordEmailScreen(),
        PinVerificationScreen.name: (context) => PinVerificationScreen(),
        ChangePasswordScreen.name: (context) => ChangePasswordScreen()
      },
    );
  }
}
