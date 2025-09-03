import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/verity_otp_screen.dart';
import 'package:e_commerce/features/shared/presentation/screens/bottom_nav_holder_screen.dart';
import 'package:flutter/material.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;

  if (settings.name == SplashScreen.name) {
    screen = SplashScreen();
  } else if (settings.name == SignInScreen.name) {
    screen = SignInScreen();
  } else if (settings.name == SignUpScreen.name) {
    screen = SignUpScreen();
  } else if (settings.name == VerifyOtpScreen.name) {
    screen = VerifyOtpScreen();
  } else if (settings.name == BottomNavHolderScreen.name) {
    screen = BottomNavHolderScreen();
  }

  return MaterialPageRoute(builder: (ctx) => screen);
}
