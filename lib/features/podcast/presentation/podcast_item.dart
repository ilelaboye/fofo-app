import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/podcast/presentation/podcast.dart';
import 'package:fofo_app/features/podcast/presentation/podcast_player.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PodcastPlayableItem extends StatelessWidget {
  final bool canPlay;
  const PodcastPlayableItem({this.canPlay = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(const PodcastPlayerPage()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.sm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: LocalImage("podcast".png, height: 100, width: 100),
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
                  ),
                  Gap.md,
                  Row(
                    children: [
                      Icon(
                        PhosphorIcons.clock,
                        size: 18,
                        color: AppColors.palette[500],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Insets.xs, left: Insets.xs),
                        child: Text(
                          "2hr 10mins",
                          style: context.textTheme.caption.size(12),
                        ),
                      )
                    ],
                  ),
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
}

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(const PodcastPage()),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: Corners.smBorder,
            child: LocalImage(
              "podcast".png,
              height: 120,
              width: 120,
            ),
          ),
          Gap.sm,
          const SizedBox(
            width: 120,
            child: Text(
              "Don’t Make Me",
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
