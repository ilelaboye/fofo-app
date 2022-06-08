import 'package:flutter/material.dart';
import 'package:fofo_app/core/presentation/app/drawer.dart';
import 'package:fofo_app/features/chat/presentation/chat_onboarding.dart';
import 'package:fofo_app/features/community/presentation/community_onboarding.dart';
import 'package:fofo_app/features/feeds/presentation/feeds.dart';
import 'package:fofo_app/features/notifications/presentation/notifications.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

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
    CommunityOnboardingPage(),
    NotificationsPage(),
    ChatOnboardingPage()
  ];
  int currentTab = 0;

  void changeTab(int index) => setState(() => currentTab = index);

  void openDrawer() => scaffoldKey.currentState!.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: Provider.value(
        value: this,
        child: IndexedStack(
          index: currentTab,
          children: tabs,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.houseSimple),
              activeIcon: Icon(PhosphorIcons.houseSimpleFill),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.applePodcastsLogo),
              activeIcon: Icon(PhosphorIcons.applePodcastsLogoFill),
              label: "Forum",
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.bell),
              activeIcon: Icon(PhosphorIcons.bellFill),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.chatsTeardrop),
              activeIcon: Icon(PhosphorIcons.chatsTeardropFill),
              label: "Chat",
            )
          ]),
    );
  }
}
