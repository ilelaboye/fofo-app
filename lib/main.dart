import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/onboarding.dart';

void main() {
  runApp(const FofoApp());
}

class FofoApp extends StatelessWidget {
  const FofoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.kTitle,
      theme: AppTheme.defaultTheme,
      home: const OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
