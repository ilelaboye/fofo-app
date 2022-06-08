import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PodcastPlayerPage extends StatelessWidget {
  const PodcastPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Black Women"),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: LocalImage("podcastLarge".png, height: context.height / 3),
            ),
            Gap.md,
            Text(
              "The Black Women Working Podcast",
              style: context.textTheme.bodyMedium
                  .size(16)
                  .changeColor(AppColors.primary)
                  .bold,
            ),
            Gap.sm,
            Text(
              "By Omoregie & Johnson",
              style: context.textTheme.caption.size(13),
            ),
            Gap.lg,
            Slider.adaptive(
              value: 0.3,
              onChanged: (value) {},
              thumbColor: AppColors.primary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "3:40",
                  style: context.textTheme.caption.size(13),
                ),
                Text(
                  "-12:45",
                  style: context.textTheme.caption.size(13),
                ),
              ],
            ),
            Gap.md,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.arrowCounterClockwise,
                    size: 27,
                    color: AppColors.palette[300],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: Insets.lg),
                    padding: const EdgeInsets.all(Insets.md),
                    decoration: BoxDecoration(
                      color: AppColors.palette[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      PhosphorIcons.playFill,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    PhosphorIcons.arrowClockwise,
                    color: AppColors.palette[300],
                    size: 27,
                  ),
                ],
              ),
            ),
            Gap.md,
            const Center(
              child: Text("1x"),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  PhosphorIcons.speakerNone,
                  color: AppColors.palette[700],
                  size: 16,
                ),
                Expanded(
                  child: Slider.adaptive(
                    value: 0.7,
                    onChanged: (value) {},
                    thumbColor: AppColors.primary,
                  ),
                ),
                Icon(
                  PhosphorIcons.speakerHigh,
                  color: AppColors.palette[700],
                  size: 16,
                ),
              ],
            ),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}
