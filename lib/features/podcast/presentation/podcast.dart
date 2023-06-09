import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/podcast/presentation/podcast_episode_list.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/utils/luncher.dart';
import '../../../core/widgets/notification.dart';
import '../../../models/library/my_library/category.dart';
import '../../../models/podcast/podcast.dart';

class PodcastPage extends StatelessWidget {
  final Podcast podcast;
  const PodcastPage({required this.podcast, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Podcast"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: Corners.smBorder,
                        child: NetworkImg(
                          podcast.podcastImage,
                          width: 140,
                          height: 140,
                        ),
                      ),
                      Gap.sm,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              podcast.name,
                              style: context.textTheme.bodyMedium.size(16).bold,
                            ),
                            // Gap.xs,
                            // Text(
                            //   "by Omoregie & Johnson",
                            //   style: context.textTheme.bodyMedium.size(14),
                            // ),
                            Gap.sm,
                            // Row(
                            //   children: [
                            //     ...List.generate(
                            //       5,
                            //       (index) => Padding(
                            //         padding: const EdgeInsets.only(right: 2),
                            //         child: Icon(
                            //           index != 4
                            //               ? PhosphorIcons.starFill
                            //               : PhosphorIcons.star,
                            //           size: 14,
                            //           color: AppColors.primary,
                            //         ),
                            //       ),
                            //     ),
                            //     Gap.xs,
                            //     const Text("(4)"),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap.lg,
                  const SectionHeader("About"),
                  Gap.sm,
                  Text(
                    podcast.description.toString(),
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                  Gap.lg,
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Host(s)"),
            ),
            Gap.sm,
            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    right: index == podcast.hosts!.length - 1 ? Insets.lg : 0,
                  ),
                  child: Column(
                    children: [
                      Avatar(
                        AppColors.colorList()[index],
                        data: CircleAvatar(
                            backgroundImage:
                                podcast.hosts![index]['image_url'] == null
                                    ? AssetImage("user".png) as ImageProvider
                                    : NetworkImage(podcast.hosts![index]
                                            ['image_url']
                                        .toString())),
                      ),
                      Gap.xs,
                      SizedBox(
                        width: 70,
                        child: Text(
                          podcast.hosts![index]['fullname'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption
                              .changeColor(AppColors.primary),
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: podcast.hosts?.length,
              ),
            ),
            Gap.lg,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Button(
                "Play",
                onTap: () {
                  var launch = Luncher();
                  if (podcast.link == null) {
                    showNotification(context, false, "Invalid host data");
                  } else {
                    launch.launchURL(context, podcast.link);
                  }
                },
              ),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}
