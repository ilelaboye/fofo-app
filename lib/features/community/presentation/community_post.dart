import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/reply_card.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommunityPostPage extends StatelessWidget {
  const CommunityPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bottomOffset = 120.0;

    return Scaffold(
      appBar: const Appbar(title: "Post"),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.md,
          vertical: Insets.md,
        ),
        color: AppColors.scaffold,
        height: bottomOffset,
        width: context.width,
        child: Column(
          children: [
            Row(
              children: [
                Avatar(AppColors.error, radius: 20),
                Gap.sm,
                Expanded(
                  child: TextInputField(
                    hintText: "Type in your response",
                    suffixIcon: const Icon(
                      PhosphorIcons.paperPlaneTiltFill,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              Row(
                children: [
                  Avatar(
                    AppColors.error,
                    radius: 24,
                  ),
                  Gap.sm,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rachel Choo",
                        style: context.textTheme.bodyMedium.size(16),
                      ),
                      Gap.xs,
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: "2hrs ago • to ",
                            style: context.textTheme.bodyMedium
                                .size(12)
                                .changeColor(AppColors.palette[700]!),
                          ),
                          const TextSpan(
                            text: "Global Community",
                          ),
                        ]),
                        style: context.textTheme.bodyMedium.size(12),
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
              const Divider(height: Insets.lg),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ReplyCard.comment(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 2,
              ),
              const Gap(bottomOffset + 50),
            ],
          ),
        ),
      ),
    );
  }
}
