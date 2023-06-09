import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  // postComment(comment) async {
  //   EasyLoading.show(status: 'loadings...');
  //   Comment index = await Provider.of<FeedsProvider>(context, listen: false)
  //       .postComment(context, widget.id, comment);
  //   _controller.clear();
  //   setState(() {
  //     blog.blogComments!.insert(0, index);
  //   });
  //   FocusScope.of(context).unfocus();
  //   EasyLoading.dismiss();
  // }

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
        // width: context.width,
        padding: const EdgeInsets.all(Insets.md),
        clipBehavior: Clip.hardEdge,
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
                  data: CircleAvatar(
                      backgroundImage: feed.createdBy!.profileImage == null
                          ? AssetImage("user".png) as ImageProvider
                          : NetworkImage(
                              feed.createdBy!.profileImage.toString())),
                ),
                Gap.sm,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.createdBy!.fullname.toString(),
                      style: context.textTheme.bodyMedium.size(14),
                    ),
                    Gap.xs,
                    SizedBox(
                      width: context.width * 0.7,
                      child: Text(ago + " • to " + feed.name.toString(),
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 14,
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.md),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  feed.description!.length > 150
                      ? feed.description.toString().substring(0, 150) + '...'
                      : feed.description.toString(),
                ),
              ),
            ),
            if (feed.blogImages!.isNotEmpty &&
                feed.blogImages![0]['image_url'] != null) ...[
              ClipRRect(
                borderRadius: Corners.smBorder,
                child: NetworkImg(
                  feed.blogImages![0]['image_url'].toString(),
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
                    Text(feed.blogLikes.toString())
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
                    Text(feed.blogComments.toString())
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
