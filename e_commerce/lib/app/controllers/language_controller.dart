import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  Locale _currentLocale = Locale('en');

  final List<Locale> _supportedLocales = [Locale('en'), Locale('bn')];

  Locale get currentLocale => _currentLocale;

  List<Locale> get supportedLocales => _supportedLocales;

  void changeLocale(Locale locale) {
    if (_currentLocale == locale) {
      return;
    }

    _currentLocale = locale;
    update();
  }
}