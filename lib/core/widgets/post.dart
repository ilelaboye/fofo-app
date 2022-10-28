import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/models/feed/feed.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../features/blog/presentation/blog.dart';

class PostCard extends StatelessWidget {
  final bool hasImage;
  final bool hasReplies;
  final Feed feed;

  const PostCard(
      {this.hasImage = false,
      this.hasReplies = false,
      required this.feed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ago;
    Duration difference =
        DateTime.now().difference(DateTime.parse(feed.createdAt));
    if (difference.inSeconds < 5) {
      ago = "Just now";
    } else if (difference.inMinutes < 1) {
      ago = "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      ago = "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      ago = "${difference.inHours}h ago";
    } else {
      ago = "${difference.inDays}d ago";
    }
    return GestureDetector(
      onTap: () => context.push(BlogPage(id: feed.id)),
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
                  data: NetworkImg(feed.creator!.profileImage.toString()),
                ),
                Gap.sm,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.creator!.fullname.toString(),
                      style: context.textTheme.bodyMedium.size(14),
                    ),
                    Gap.xs,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: ago + " • to ",
                          style: context.textTheme.bodyMedium
                              .size(10)
                              .changeColor(AppColors.palette[700]!),
                        ),
                        TextSpan(
                          text: feed.title.toString(),
                        ),
                      ]),
                      style: context.textTheme.bodyMedium.size(10),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Insets.md),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  feed.description!.length > 150
                      ? feed.description.toString().substring(0, 150) + '...'
                      : feed.description.toString(),
                ),
              ),
            ),
            if (feed.blogImagePath != null) ...[
              ClipRRect(
                borderRadius: Corners.smBorder,
                child: NetworkImg(
                  feed.blogImagePath.toString(),
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
                    Text(feed.likes_count.toString())
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
                    Text(feed.comments_count.toString())
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
