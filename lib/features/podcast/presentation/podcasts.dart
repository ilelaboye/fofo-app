import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/podcast/presentation/podcast_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PodcastsPage extends StatelessWidget {
  const PodcastsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Podcast"),
      bottomSheet: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppColors.palette[300]!,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: Insets.sm, horizontal: Insets.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: LocalImage("podcast".png, height: 60, width: 60),
            ),
            Gap.sm,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Don’t make me think: A common sense approach to career thinking • EP 10",
                    style: context.textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                  Gap.xs,
                  Text(
                    "Host : Omoregie Johnson & Bella",
                    style: context.textTheme.caption.size(12),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                children: [
                  TextInputField(
                    hintText: "Titles, authors & topics",
                    prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                  ),
                  Gap.lg,
                  CategorySection(
                    categories: [],
                    // categories: categoryItems(),
                  ),
                  Gap.lg,
                  const SectionHeader("Recently Played", seeAll: true),
                  Gap.sm,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        const PodcastPlayableItem(),
                    itemCount: 2,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Popular", seeAll: true),
            ),
            Gap.sm,
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    right: index == 9 ? Insets.lg : 0,
                  ),
                  child: const PodcastListItem(),
                ),
                itemCount: 4,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Top podcasters", seeAll: true),
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
                    right: index == 9 ? Insets.lg : 0,
                  ),
                  child: Avatar(
                    AppColors.colorList()[index],
                  ),
                ),
                itemCount: 10,
              ),
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("You might like", seeAll: true),
            ),
            Gap.sm,
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    right: index == 9 ? Insets.lg : 0,
                  ),
                  child: const PodcastListItem(),
                ),
                itemCount: 4,
              ),
            ),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}
