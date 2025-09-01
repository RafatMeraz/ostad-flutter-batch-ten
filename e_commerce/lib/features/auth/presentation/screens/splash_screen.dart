import 'package:e_commerce/app/extensions/localization_extension.dart';
import 'package:e_commerce/app/utils/app_version_service.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text(
                '${context.localization.version} '
                '${AppVersionService.currentAppVersion}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
