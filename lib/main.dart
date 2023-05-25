// ignore_for_file: unused_element, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/onboarding.dart';
import 'package:fofo_app/service/course/course.dart';
import 'package:fofo_app/service/feed/feed.dart';
import 'package:fofo_app/service/job/job.dart';
import 'package:fofo_app/service/library/my_library_provider.dart';
import 'package:fofo_app/service/podcast/podcast.dart';
import 'package:fofo_app/service/shop/shop.dart';
import 'package:provider/provider.dart';

import 'core/presentation/app/app_scaffold.dart';
import 'service/auth_service/auth_provider.dart';
import 'service/user_provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Kzz4mBSyohQ7ttbTspbenL6d9AoDdjdRlqbT9bFRe7mTPllaqiBD9HjgrGhWRVst2pD13F9aizC58y2bYzcXixO00JLrLw5N9';
  Stripe.merchantIdentifier = 'FofoApp';
  await Stripe.instance.applySettings();
  final auth = AuthProvider();
  await auth.init();
  configLoading();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => auth),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => LibraryProvider()),
    ChangeNotifierProvider(create: (_) => FeedsProvider()),
    ChangeNotifierProvider(create: (_) => ShopProvider()),
    ChangeNotifierProvider(create: (_) => CoursesProvider()),
    ChangeNotifierProvider(create: (_) => PodcastProvider()),
    ChangeNotifierProvider(create: (_) => JobProvider())
  ], child: FofoApp()));
}

class FofoApp extends StatefulWidget {
  FofoApp({Key? key}) : super(key: key);

  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<FofoApp> createState() => _FofoAppState();
}

class _FofoAppState extends State<FofoApp> {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    bool skipOnboard = auth.getSkipOnboarding();

    print('print skip');
    print(skipOnboard);
    return MaterialApp(
        title: AppStrings.kTitle,
        theme: AppTheme.defaultTheme,
        home: skipOnboard ? AppScaffoldPage() : OnboardingPage(),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init()
        // navigatorKey: widget.navigatorKey,
        );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    // ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue
    ..userInteractions = true
    ..dismissOnTap = false;
}
