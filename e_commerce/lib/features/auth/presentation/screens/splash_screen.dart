import 'package:e_commerce/app/asset_paths.dart';
import 'package:e_commerce/app/extensions/localization_extension.dart';
import 'package:e_commerce/app/utils/app_version_service.dart';
import 'package:e_commerce/features/shared/presentation/widgets/language_change_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              SvgPicture.asset(AssetPaths.logoSvg, width: 120),
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
