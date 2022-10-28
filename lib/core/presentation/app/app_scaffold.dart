import 'package:flutter/material.dart';
import 'package:fofo_app/core/presentation/app/drawer.dart';
import 'package:fofo_app/features/chat/presentation/chat_onboarding.dart';
import 'package:fofo_app/features/community/presentation/community_onboarding.dart';
import 'package:fofo_app/features/feeds/presentation/feeds.dart';
import 'package:fofo_app/features/notifications/presentation/notifications.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/library/my_library_provider.dart';

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
  void initState() {
    super.initState();
    // Provider.of<FeedsProvider>(context, listen: false).getFeeds(context);
    Future.delayed(
        const Duration(seconds: 10),
        () => Provider.of<LibraryProvider>(context, listen: false)
            .getLibrary(context));
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider user = Provider.of<AuthProvider>(context);
    // print(user.getUser());
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
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
