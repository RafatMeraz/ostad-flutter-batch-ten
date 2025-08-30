import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService {
  static String? _currentAppVersion;

  static Future<void> getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _currentAppVersion = packageInfo.version;
  }

  static String get currentAppVersion => _currentAppVersion ?? '';
}