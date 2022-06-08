import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/subscription/presentation/checkout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MembershipPlanPage extends StatelessWidget {
  final List<String> perks;
  const MembershipPlanPage(this.perks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Gap.md,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$250",
                  style: context.textTheme.headlineLarge
                      .changeColor(AppColors.primary),
                ),
                Gap.sm,
                Text(
                  "/ Year",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.primary),
                ),
                const Spacer(),
                CupertinoSwitch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (value) {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.lg, vertical: Insets.xs),
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.infoFill,
                  size: 18,
                  color: AppColors.palette[500],
                ),
                const Gap(4),
                Expanded(
                  child: Text(
                    "You save \$50 & you get 2 months subscription free",
                    style: context.textTheme.caption!
                        .changeColor(const Color(0xff40BF95)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gold Access",
                  style: context.textTheme.headlineMedium
                      .changeColor(AppColors.primary)
                      .size(24)
                      .bold,
                ),
                Gap.sm,
                Text(
                  "Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success. We’ll help you and clarify your purpose, overcome impostor syndr see more...",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.palette[700]!)
                      .size(12)
                      .copyWith(height: 1.4),
                ),
                Gap.md,
                const SectionHeader("Benefits"),
                Gap.sm,
                Text(
                  "Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success. We’ll help you and clarify your purpose, overcome impostor syndr see more...",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.palette[700]!)
                      .size(12)
                      .copyWith(height: 1.4),
                ),
                Gap.sm,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: perks.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: Insets.sm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        Gap.sm,
                        Expanded(
                          child: Text(
                            perks[index],
                            style: context.textTheme.bodyMedium
                                .changeColor(AppColors.palette[700]!)
                                .size(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SectionHeader(
                  "Members",
                  seeAll: true,
                ),
                Gap.sm,
                AvatarGroup(AppColors.colorList()),
                Gap.md,
                const SectionHeader("Reviews"),
                Gap.sm,
              ],
            ),
          ),
          const ReviewList(),
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Button(
              "Choose This Plan",
              onTap: () => context.push(const CheckoutPage()),
            ),
          ),
          Gap.lg,
        ],
      )),
    );
  }
}
