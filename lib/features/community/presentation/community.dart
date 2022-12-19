import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/create_post.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/post_card.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: "BLK GRL Community",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Insets.sm),
            child: IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => const GuidelineSheet(),
                );
              },
              icon: Icon(
                PhosphorIcons.info,
                color: AppColors.primary,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push(const CreatePostPage()),
        child: const Icon(
          PhosphorIcons.plus,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(
                hasImage: true,
              ),
            ),
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.md),
              child: SectionHeader(
                "Just Joined",
                seeAll: true,
              ),
            ),
            Gap.md,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => Avatar(AppColors.colorList()[index]),
                ),
              ),
            ),
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(
                hasReplies: true,
              ),
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}

class GuidelineSheet extends StatelessWidget {
  const GuidelineSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.fromLTRB(Insets.md, Insets.lg, Insets.md, Insets.lg),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
      ),
      padding: const EdgeInsets.all(Insets.lg),
      child: Material(
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(PhosphorIcons.usersThin, size: 70),
                  Gap.sm,
                  Text(
                    "Community Guidelines",
                    style: context.textTheme.headlineSmall.bold
                        .changeColor(AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  Gap.sm,
                  Text(
                    "Our online member experience provides a social space for members to share ideas, resources, challenges and solutions. It is a supportive and respectful community that values substantive conversation and a fun atmosphere. In order to maintain this environment, we kindly ask that our members refrain from:",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium
                        .changeColor(AppColors.palette[600])
                        .copyWith(height: 1.4),
                  ),
                  Text(
                    '''
            - Using language that is rude, divisive or otherwise inappropriate
            - Posting or sharing content that is not work safe
            - Soliciting or promoting
            ''',
                    style: context.textTheme.bodyMedium
                        .changeColor(AppColors.primary)
                        .copyWith(height: 1.4),
                  ),
                  Text(
                    'Our team of Community Moderators is here to support you throughout your experience. You can reach us here: support@trailblazerfemme.com.',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium
                        .changeColor(AppColors.palette[600])
                        .copyWith(height: 1.4),
                  ),
                  Gap.lg,
                  Button(
                    "I Agree To These Guidelines",
                    onTap: () => context.pop(),
                  )
                ],
              ),
            ),
            Positioned(
              child: Icon(
                PhosphorIcons.xCircleFill,
                color: AppColors.primary,
              ).onTap(() => context.pop()),
            )
          ],
        ),
      ),
    );
  }
}
