import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/community/presentation/community_post.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PostCard extends StatelessWidget {
  final bool hasImage;
  final bool hasReplies;

  const PostCard({this.hasImage = false, this.hasReplies = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(const CommunityPostPage()),
      child: Container(
        width: context.width,
        padding: const EdgeInsets.all(Insets.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Corners.smBorder,
          border: Border.all(
            color: AppColors.palette[200]!,
            width: 0.7,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Avatar(
                  AppColors.error,
                  radius: 18,
                ),
                Gap.sm,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rachel Choo",
                      style: context.textTheme.bodyMedium.size(14),
                    ),
                    Gap.xs,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "2hrs ago • to ",
                          style: context.textTheme.bodyMedium
                              .size(10)
                              .changeColor(AppColors.palette[700]!),
                        ),
                        const TextSpan(
                          text: "Global Community",
                        ),
                      ]),
                      style: context.textTheme.bodyMedium.size(10),
                    )
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Insets.md),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipis cin consequa hendrerit posuere cin consequat hendrerit posuere. In pellen esq ue vulp nec diam sed ligula pulvinar.",
              ),
            ),
            if (hasImage) ...[
              ClipRRect(
                borderRadius: Corners.smBorder,
                child: LocalImage(
                  "post".png,
                  width: context.width,
                  height: 200,
                ),
              ),
              Gap.md,
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.heartFill,
                      color: AppColors.palette[600],
                      size: 17,
                    ),
                    Gap.xs,
                    const Text("10")
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.chatTeardrop,
                      color: AppColors.palette[700],
                      size: 17,
                    ),
                    Gap.xs,
                    const Text("4")
                  ],
                )
              ],
            ),
            // if (hasReplies) ...[const Divider(height: Insets.lg)]
          ],
        ),
      ),
    );
  }
}
