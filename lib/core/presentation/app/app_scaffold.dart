import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/presentation/app/drawer.dart';
import 'package:fofo_app/features/feeds/presentation/feeds.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../features/auth/presentation/login.dart';
import '../../../features/library/presentation/library.dart';
import '../../../features/podcast/presentation/podcasts.dart';
import '../../../features/shop/presentation/shop.dart';
import '../../../models/profile/user_profile/user_profile.dart';
import '../../../service/auth_service/auth_provider.dart';
import '../../widgets/notification.dart';

class AppScaffoldPage extends StatefulWidget {
  const AppScaffoldPage({Key? key}) : super(key: key);
  static _AppScaffoldPageState of(BuildContext context) =>
      context.read<_AppScaffoldPageState>();
  @override
  _AppScaffoldPageState createState() => _AppScaffoldPageState();
}

class _AppScaffoldPageState extends State<AppScaffoldPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> tabs = const [
    FeedsPage(),
    LibraryPage(),
    ShopPage(),
    PodcastsPage()
    // CommunityOnboardingPage(),
    // NotificationsPage(),
    // ChatOnboardingPage()
  ];
  int currentTab = 0;

  void changeTab(int index) => setState(() => currentTab = index);

  void openDrawer() => scaffoldKey.currentState!.openDrawer();
  late final UserProfile? profile;

  @override
  void initState() {
    super.initState();
    // getProfile();
    profile = Provider.of<AuthProvider>(context, listen: false).userProfile;
  }

  // getProfile() async {
  //   print(
  //       'scaffold toke - ${Provider.of<AuthProvider>(context, listen: false).token.toString()}');
  //   profile = await Provider.of<AuthProvider>(context, listen: false)
  //       .getUserProfile(context,
  //           Provider.of<AuthProvider>(context, listen: false).token.toString());
  //   print('after get profile');
  //   if (profile == null) {
  //     showNotification(context, false, "Unauthorized access, please login");
  //     Provider.of<AuthProvider>(context, listen: false).logOut(context);
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const LoginPage()),
  //         (route) => false);
  //   } else {
  //     Provider.of<AuthProvider>(context, listen: false).setUser(profile!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // bool? shouldPop = true;
        bool? shouldPop = Navigator.canPop(context)
            ? true
            : await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Do you want to exit the app?'),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );

        return shouldPop!;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(),
        body: Provider.value(
          value: this,
          child: tabs[currentTab],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.primary,
            fixedColor: Colors.white,
            currentIndex: currentTab,
            iconSize: 30,
            unselectedItemColor: Colors.grey[350],
            onTap: changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  PhosphorIcons.houseSimple,
                ),
                activeIcon: Icon(PhosphorIcons.houseSimpleFill),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  PhosphorIcons.lifebuoy,
                ),
                activeIcon: Icon(PhosphorIcons.lifebuoyFill),
                label: "Services",
              ),
              BottomNavigationBarItem(
                icon: Icon(PhosphorIcons.storefront),
                activeIcon: Icon(PhosphorIcons.storefrontFill),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: Icon(PhosphorIcons.shareNetwork),
                activeIcon: Icon(PhosphorIcons.shareNetworkFill),
                label: "Network",
              )
            ]),
      ),
    );
  }
}
