import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/price_badge.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/community/presentation/community_about.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Communities",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Communities are groups of people that connect for work, projects, or common interests.",
              ),
              Gap.md,
              TextInputField(
                hintText: "Search through communities",
                prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
              ),
              Gap.lg,
              const CommunityItem(
                Color(0xffE99F0C),
                free: false,
              ),
              Gap.sm,
              const CommunityItem(Color(0xff3B9B7B)),
              Gap.sm,
              const CommunityItem(Color(0xff4751D1)),
              const Gap(50)
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityItem extends StatelessWidget {
  final Color color;
  final bool free;

  const CommunityItem(this.color, {this.free = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(color: color, width: 0.5),
        borderRadius: Corners.smBorder,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BLK GRL Community",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textTheme.bodyMedium.changeColor(color),
                  ),
                  Text(
                    "Whether stepping into a C-suite or position, we help you live purposefully",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textTheme.caption
                        .size(13)
                        .changeColor(color.withOpacity(0.8)),
                  ),
                ],
              )),
              PriceBadge(free: free)
            ],
          ),
          Gap.lg,
          Row(
            children: [
              Expanded(
                child: AvatarGroup(
                  AppColors.colorList(),
                  trailing: Text(
                    "People",
                    style:
                        context.textTheme.caption.size(10).changeColor(color),
                  ),
                  textStyle:
                      context.textTheme.caption.size(10).changeColor(color),
                  groupRadius: 16,
                  showCount: 4,
                  leftPadding: 14,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Join community",
                    style: context.textTheme.caption.changeColor(color),
                  ),
                  Gap.sm,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: Icon(
                      PhosphorIcons.arrowRight,
                      size: 18,
                      color: color,
                    ),
                  )
                ],
              ).onTap(() async {
                if (free) {
                  context.push(const CommunityAboutPage());
                } else {
                  final value = await showCupertinoModalPopup(
                    context: context,
                    builder: (context) => const ExclusiveBottomSheet(),
                  );
                  if (value != null) {
                    context.push(const CommunityAboutPage());
                  }
                }
              })
            ],
          ),
        ],
      ),
    );
  }
}

class ExclusiveBottomSheet extends StatelessWidget {
  const ExclusiveBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(Insets.md, 0, Insets.md, Insets.lg),
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
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(PhosphorIcons.infoThin, size: 100),
                Gap.sm,
                Text(
                  "Oops :(",
                  style: context.textTheme.headlineSmall.bold
                      .changeColor(AppColors.primary),
                  textAlign: TextAlign.center,
                ),
                Gap.sm,
                Text(
                  "This is content not available for users on your membership plan, you can upgrade to an higher plan to access this content.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.palette[600])
                      .copyWith(height: 1.4),
                ),
                Gap.lg,
                Button(
                  "Upgrade Membership Plan",
                  onTap: () => context.pop("approved"),
                )
              ],
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
