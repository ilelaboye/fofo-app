import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/price_badge.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Course"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Column(
                children: [
                  Gap.md,
                  Text(
                    "Strategic planning for c-suite career.",
                    style: context.textTheme.headlineMedium.bold
                        .size(24)
                        .changeColor(AppColors.primary),
                  ),
                  Gap.md,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: Corners.mdBorder,
                        child: LocalImage(
                          "course_preview".png,
                          height: 200,
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          clipBehavior: Clip.hardEdge,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: const Icon(
                              PhosphorIcons.play,
                              size: 27,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Gap.sm,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: Insets.xs),
                            child: Text(
                              "by Jasmine Cole • ",
                              style: context.textTheme.caption.size(12),
                            ),
                          ),
                          ...List.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Icon(
                                PhosphorIcons.starFill,
                                size: 14,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Text(
                            "(5)",
                            style: context.textTheme.caption
                                .size(12)
                                .changeColor(AppColors.primary),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.clock,
                            size: 18,
                            color: AppColors.palette[500],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: Insets.xs),
                            child: Text(
                              "1hr 30mins",
                              style: context.textTheme.caption.size(12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap.md,
                  Row(
                    children: [
                      Text(
                        "Description",
                        style: context.textTheme.headlineMedium
                            .changeColor(AppColors.primary)
                            .size(18)
                            .bold,
                      ),
                      Gap.sm,
                      const PriceBadge(free: false)
                    ],
                  ),
                  Gap.sm,
                  Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words whichdon't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't any thing embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet to repeat predefined chunks as necessary, making this the  first true generator on the Internet. It uses a dictionary of  over 200 Latin words, combined with a handful of model  sentence structures, to generate Lorem Ipsum which looks  reasonable... show less",
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                ],
              ),
            ),
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Tutor(s)"),
            ),
            Gap.sm,
            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    // use index == tutors.length -1
                    right: index == 2 ? Insets.lg : 0,
                  ),
                  child: Column(
                    children: [
                      Avatar(AppColors.colorList()[index]),
                      Gap.xs,
                      SizedBox(
                        width: 70,
                        child: Text(
                          "Jasmine Cole",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption
                              .changeColor(AppColors.primary),
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 3,
              ),
            ),
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Reviews"),
            ),
            Gap.sm,
            const ReviewList(),
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Similar Courses", seeAll: true),
            ),
            Gap.sm,
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    // use index == review.length -1
                    right: index == 2 ? Insets.lg : 0,
                  ),
                  child: SimilarCourseCard(
                    free: index % 2 == 0,
                  ),
                ),
                itemCount: 3,
              ),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}

class SimilarCourseCard extends StatelessWidget {
  final bool free;
  const SimilarCourseCard({this.free = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(Insets.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: AppColors.palette[200]!,
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: Corners.smBorder,
                child: LocalImage(
                  "course_preview".png,
                  width: context.width,
                  height: 100,
                ),
              ),
              Positioned(
                bottom: Insets.xs,
                right: Insets.xs,
                left: Insets.xs,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceBadge(
                      free: free,
                    ),
                    Row(
                      children: [
                        const Icon(
                          PhosphorIcons.clockFill,
                          size: 14,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, top: 2),
                          child: Text(
                            "1hr 30mins",
                            style: context.textTheme.caption
                                .size(10)
                                .changeColor(Colors.white)
                                .bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Gap.xs,
          Text(
            "Progressing in career as a black woman",
            maxLines: 2,
            style: context.textTheme.caption
                .changeColor(AppColors.palette[600]!)
                .size(14)
                .bold,
          ),
          Gap.xs,
          Row(
            children: [
              Icon(
                PhosphorIcons.user,
                size: 18,
                color: AppColors.palette[500],
              ),
              Gap.xs,
              Text(
                "Ray Alex",
                style: context.textTheme.bodySmall
                    .changeColor(AppColors.palette[600]!),
              ),
            ],
          )
        ],
      ),
    );
  }
}
