import 'package:e_commerce/app/extensions/localization_extension.dart';
import 'package:e_commerce/features/auth/data/models/login_request_model.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce/features/auth/presentation/widgets/app_logo.dart';
import 'package:e_commerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../shared/presentation/screens/bottom_nav_holder_screen.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 48),
                AppLogo(width: 100),
                const SizedBox(height: 24),
                Text(
                  context.localization.welcomeBack,
                  style: textTheme.titleLarge,
                ),
                Text(
                  context.localization.loginHeadline,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 16),
                GetBuilder<LoginController>(
                  builder: (_) {
                    return Visibility(
                      visible: _loginController.logInProgress == false,
                      replacement: CenteredCircularProgress(),
                      child: FilledButton(
                        onPressed: _onTapLoginButton,
                        child: Text('Login'),
                      ),
                    );
                  }
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _onTapSignUpButton,
                  child: Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    // TODO: Validate form
    _signIn();
  }

  Future<void> _signIn() async {
    LoginRequestModel model = LoginRequestModel(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text);
    bool isSuccess = await _loginController.login(model);
    if (isSuccess) {
      await Get.find<AuthController>().saveUserData(
          _loginController.userModel!, _loginController.accessToken!);
      Navigator.pushNamedAndRemoveUntil(
          context, BottomNavHolderScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, _loginController.errorMessage!);
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
