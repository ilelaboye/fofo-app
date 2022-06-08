import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum Reply { comment, shared }

class ReplyCard extends StatelessWidget {
  final Reply reply;
  const ReplyCard._({required this.reply, Key? key}) : super(key: key);

  factory ReplyCard.comment() => const ReplyCard._(reply: Reply.comment);
  factory ReplyCard.shared() => const ReplyCard._(reply: Reply.shared);

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
          ),
          Gap.sm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sarah Ray",
                  style: context.textTheme.bodyMedium.size(14),
                ),
                Gap.xs,
                Text(
                  "2hrs ago",
                  style: context.textTheme.caption,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.md),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipis cin consequa hendrerit posuere cin consequat hendrerit posuere. In pellen esq ue vulp nec diam sed ligula pulvinar.",
                  ),
                ),
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
                        const Text("4")
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
                        const Text("2")
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
