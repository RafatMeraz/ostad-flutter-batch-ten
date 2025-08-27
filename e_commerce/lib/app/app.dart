import 'package:e_commerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:e_commerce/l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorObservers: [observer],
      locale: Locale('bn'),
      supportedLocales: [Locale('en'), Locale('bn')],
      home: SplashScreen(),
    );
  }
}
