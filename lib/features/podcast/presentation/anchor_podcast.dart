import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:fofo_app/core/widgets/appbar.dart';

import '../../../config/constants.dart';

class AnchorPodcast extends StatefulWidget {
  final String url;
  const AnchorPodcast({Key? key, required this.url}) : super(key: key);

  @override
  State<AnchorPodcast> createState() => _AnchorPodcastState();
}

class _AnchorPodcastState extends State<AnchorPodcast> {
  @override
  void initState() {
    super.initState();
    _launchURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Podcast"),
      // body: WebView(
      //   initialUrl: "https://www.google.com",
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }

  Future<void> _launchURL() async {
    print('loding');
    try {
      await launch(
        'https://flutter.dev',
        customTabsOption: CustomTabsOption(
          toolbarColor: AppColors.primary,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsSystemAnimation.slideIn(),
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: AppColors.primary,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
