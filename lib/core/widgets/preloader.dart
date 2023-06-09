import 'package:flutter/material.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/login.dart';
import '../../models/profile/user_profile/user_profile.dart';
import '../../service/auth_service/auth_provider.dart';
import '../presentation/app/app_scaffold.dart';
import 'image.dart';
import 'notification.dart';

class Preloader extends StatefulWidget {
  const Preloader({Key? key}) : super(key: key);

  @override
  State<Preloader> createState() => _PreloaderState();
}

class _PreloaderState extends State<Preloader> {
  late final UserProfile? profile;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  getProfile() async {
    print(
        'scaffold toke - ${Provider.of<AuthProvider>(context, listen: false).token.toString()}');
    profile = await Provider.of<AuthProvider>(context, listen: false)
        .getUserProfile(context,
            Provider.of<AuthProvider>(context, listen: false).token.toString());
    print('after get profile');
    if (profile == null) {
      print('loff');
      // showNotification(context, false, "Unauthorized access, please login");
      // Provider.of<AuthProvider>(context, listen: false).logOut(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    } else {
      Provider.of<AuthProvider>(context, listen: false).setUser(profile!);
      context.push(AppScaffoldPage());
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const AppScaffoldPage()),
      //     (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeInImage(
          fadeOutDuration: new Duration(milliseconds: 300),
          fadeOutCurve: Curves.decelerate,
          placeholder: AssetImage('assets/images/logo.png'),
          image: AssetImage('assets/images/logo.png'),
        ),
      ],
    );
  }
}
