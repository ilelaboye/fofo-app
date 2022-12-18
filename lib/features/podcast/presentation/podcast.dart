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

import '../../../models/library/my_library/category.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Podcast"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: Corners.smBorder,
                        child: LocalImage(
                          "podcast".png,
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
                              "The Black Women Working Podcast",
                              style: context.textTheme.bodyMedium.size(16).bold,
                            ),
                            Gap.xs,
                            Text(
                              "by Omoregie & Johnson",
                              style: context.textTheme.bodyMedium.size(14),
                            ),
                            Gap.sm,
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Icon(
                                      index != 4
                                          ? PhosphorIcons.starFill
                                          : PhosphorIcons.star,
                                      size: 14,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                Gap.xs,
                                const Text("(4)"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap.lg,
                  const SectionHeader("About"),
                  Gap.sm,
                  Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words whichdon't look even slightly believable. ... See mores",
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                  Gap.sm,
                  CategorySection(
                    showTitle: false,
                    categories: [
                      Category(name: "Career"),
                      Category(name: "Black Women")
                    ],
                  ),
                  Gap.lg,
                  SectionHeader(
                    "Episodes",
                    seeAll: true,
                    onClickSeeAll: () =>
                        context.push(const PodcastEpisodesListPage()),
                  ),
                  Gap.sm,
                  // ListView.builder(
                  //   padding: EdgeInsets.zero,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) =>
                  //       const PodcastPlayableItem(canPlay: true),
                  //   itemCount: 3,
                  // ),
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
                    right: index == 2 ? Insets.lg : 0,
                  ),
                  child: Column(
                    children: [
                      Avatar(AppColors.colorList()[index]),
                      Gap.xs,
                      SizedBox(
                        width: 70,
                        child: Text(
                          "Jasmine Cole",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption
                              .changeColor(AppColors.primary),
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 2,
              ),
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Reviews"),
            ),
            Gap.md,
            const ReviewList(),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Similar podcasts", seeAll: true),
            ),
            Gap.md,
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    right: index == 2 ? Insets.lg : 0,
                  ),
                  // child: const PodcastListItem(),
                ),
                itemCount: 3,
              ),
            ),
            Gap.lg,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Button(
                "Notify Me About New Episodes",
                onTap: () {},
              ),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}
