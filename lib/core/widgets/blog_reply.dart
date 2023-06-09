import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/models/feed/comment.dart';

class ReplyCard extends StatelessWidget {
  final Comment comment;
  const ReplyCard({required this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.all(Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            AppColors.error,
            radius: 20,
            data: CircleAvatar(
                backgroundColor: Colors.red,
                backgroundImage: comment.commentedBy != null
                    ? comment.commentedBy!.profileImage == null
                        ? AssetImage("user".png) as ImageProvider
                        : NetworkImage(comment.commentedBy!.profileImage ?? "")
                    : AssetImage("user".png) as ImageProvider),
          ),
          Gap.sm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.commentedBy != null
                      ? comment.commentedBy!.fullname.toString()
                      : '',
                  style: context.textTheme.bodyMedium.size(14),
                ),
                Gap.xs,
                Text(
                  comment.createdAt!.getDateDifference(),
                  style: context.textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.md),
                  child: Text(
                    comment.comment.toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
