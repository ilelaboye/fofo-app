// ignore_for_file: unused_element, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/onboarding.dart';
import 'package:fofo_app/models/user_model/user_model.dart';
import 'package:fofo_app/service/auth_service/auth_service.dart';
import 'package:fofo_app/service/library/my_library_provider.dart';
import 'package:fofo_app/service/profile_service/profile_provider.dart';
import 'package:provider/provider.dart';

import 'core/presentation/app/app_scaffold.dart';
import 'features/auth/presentation/login.dart';
import 'service/auth_service/auth_provider.dart';
import 'service/user_provider/user_preference.dart';
import 'service/user_provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Kzz4mBSyohQ7ttbTspbenL6d9AoDdjdRlqbT9bFRe7mTPllaqiBD9HjgrGhWRVst2pD13F9aizC58y2bYzcXixO00JLrLw5N9';
  final auth = AuthProvider();
  await auth.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => auth),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    Provider<SignUpService>(create: (_) => SignUpService()),
    ChangeNotifierProvider(create: (_) => LibraryProvider())
  ], child: FofoApp(token: auth.token)));
}

class FofoApp extends StatefulWidget {
  FofoApp({required this.token, Key? key}) : super(key: key);
  String? token;
  @override
  State<FofoApp> createState() => _FofoAppState();
}

class _FofoAppState extends State<FofoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.kTitle,
      theme: AppTheme.defaultTheme,
       home: 
      //widget.token != null ? AppScaffoldPage() :
 OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
