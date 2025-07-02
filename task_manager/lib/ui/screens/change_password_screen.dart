import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String name = '/change-password';

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Password should be more than 6 letters.',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                        color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: 'Password'
                    ),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                    validator: (String? value) {
                      if ((value ?? '') != _passwordTEController.text) {
                        return "Confirm password doesn't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Text('Confirm'),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    // if (_formKey.currentState!.validate()) {
    //   // TODO: Sign in with API
    // }
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.name, (predicate) => false);
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
