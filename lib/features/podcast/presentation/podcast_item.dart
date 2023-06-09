import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/podcast/presentation/podcast.dart';
import 'package:fofo_app/models/podcast/podcast.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/widgets/notification.dart';

class PodcastPlayableItem extends StatelessWidget {
  final bool canPlay;
  final Podcast podcast;
  const PodcastPlayableItem(
      {this.canPlay = false, required this.podcast, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        podcast.link == null
            ? showNotification(context, false, "Invalid host data")
            : _launchURL(context, podcast.link)
      },
      // onTap: () => context.push(const PodcastPlayerPage()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.sm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: NetworkImg(podcast.podcastImage, height: 100, width: 100),
            ),
            Gap.sm,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    podcast.name,
                    style: context.textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                  Gap.xs,
                  // Text(
                  //   "Host : Omoregie Johnson & Bella",
                  //   style: context.textTheme.caption.size(12),
                  // ),
                  // Gap.md,
                  // Row(
                  //   children: [
                  //     Icon(
                  //       PhosphorIcons.clock,
                  //       size: 18,
                  //       color: AppColors.palette[500],
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(
                  //           top: Insets.xs, left: Insets.xs),
                  //       child: Text(
                  //         "2hr 10mins",
                  //         style: context.textTheme.caption.size(12),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            if (canPlay) ...[
              Gap.lg,
              Container(
                padding: const EdgeInsets.all(Insets.sm),
                decoration: BoxDecoration(
                  color: AppColors.palette[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  PhosphorIcons.playFill,
                  color: Colors.white,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  // Future<void> _launchURL(BuildContext context) async {
  //   try {
  //     await launch(
  //       link,
  //       customTabsOption: CustomTabsOption(
  //         toolbarColor: AppColors.primary,
  //         enableDefaultShare: true,
  //         enableUrlBarHiding: true,
  //         showPageTitle: true,
  //         animation: CustomTabsSystemAnimation.slideIn(),
  //         extraCustomTabs: const <String>[
  //           // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
  //           'org.mozilla.firefox',
  //           // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
  //           'com.microsoft.emmx',
  //         ],
  //       ),
  //       safariVCOption: SafariViewControllerOption(
  //         preferredBarTintColor: AppColors.primary,
  //         preferredControlTintColor: Colors.white,
  //         barCollapsingEnabled: true,
  //         entersReaderIfAvailable: false,
  //         dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
  //       ),
  //     );
  //   } catch (e) {
  //     // An exception is thrown if browser app is not installed on Android device.
  //     debugPrint(e.toString());
  //   }
  // }
}

Future<void> _launchURL(BuildContext context, link) async {
  try {
    await launch(
      link,
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

class PodcastListItem extends StatelessWidget {
  final Podcast podcast;
  const PodcastListItem({required this.podcast, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(PodcastPage(
        podcast: podcast,
      )),
      // onTap: () => _launchURL(context, podcast.link),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: Corners.smBorder,
            child: NetworkImg(
              podcast.podcastImage,
              height: 120,
              width: 120,
            ),
          ),
          Gap.sm,
          SizedBox(
            width: 120,
            child: Text(
              podcast.name,
              maxLines: 1,
            ),
          ),
          Gap.xs,
          SizedBox(
            width: 120,
            child: Text(
              "Omoregie & Johnson",
              maxLines: 1,
              style: context.textTheme.caption.size(12),
            ),
          )
        ],
      ),
    );
  }
}
