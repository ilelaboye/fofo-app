import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/jobs/presentation/job.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Jobs",
        hasLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      hintText: "Job title, company",
                      prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                    ),
                  ),
                  Gap.md,
                  const Icon(PhosphorIcons.funnel)
                ],
              ),
              Gap.lg,
              CategorySection(
                  categories: jobsCategoryItemsNoIcons(), seeAll: true),
              Gap.lg,
              const SectionHeader("Recommended", seeAll: true),
              Gap.md,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.xs + 2),
                  child: JobItem(),
                ).onTap(() => context.push(const JobPage())),
                itemCount: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobItem extends StatelessWidget {
  const JobItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Admin Assistant",
                      style: context.textTheme.bodyMedium.size(14).bold,
                    ),
                    Gap.xs,
                    Text(
                      "Zetti Compliance Ltd",
                      style: context.textTheme.bodyMedium.size(13),
                    ),
                    Gap.xs,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "New York, USA • ",
                          style: context.textTheme.bodyMedium
                              .size(10)
                              .changeColor(AppColors.palette[700]!),
                        ),
                        const TextSpan(
                          text: "Full time",
                        ),
                      ]),
                      style: context.textTheme.bodyMedium.size(10),
                    )
                  ],
                ),
              ),
              const Icon(PhosphorIcons.dotsThreeVertical)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.md),
            child: Text(
              "Admin assistant will be providing day to day local/remote desktop support, receive both inbound and outbound...",
              style: context.textTheme.caption.size(13),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    PhosphorIcons.paperPlaneRightLight,
                    color: AppColors.palette[600],
                    size: 15,
                  ),
                  Gap.xs,
                  Text(
                    "Apply",
                    style: context.textTheme.bodyMedium.size(12).bold,
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    PhosphorIcons.clock,
                    color: AppColors.palette[700],
                    size: 15,
                  ),
                  Gap.xs,
                  Text(
                    "4 Days Ago",
                    style: context.textTheme.caption.size(12),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
