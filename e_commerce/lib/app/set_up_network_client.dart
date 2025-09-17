import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/core/services/network_caller.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(onUnAuthorize: _onUnAuthorize, accessToken: '');
}

Future<void> _onUnAuthorize() async {
  // TODO: remove cache
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.name,
    (predicate) => false,
  );
}
