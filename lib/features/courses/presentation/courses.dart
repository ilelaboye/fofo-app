import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/price_badge.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/courses/presentation/course.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Courses",
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Column(
              children: [
                TextInputField(
                  hintText: "Titles, authors & topics",
                  prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                ),
                Gap.lg,
                CategorySection(
                  categories: [],
                  // categories: categoryItems(),
                ),
                Gap.lg,
                const SectionHeader("All courses"),
                Gap.sm,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CourseItem(
                    free: (index % 2) == 0,
                  ),
                  itemCount: 7,
                )
              ],
            ),
          )),
    );
  }
}

class CourseItem extends StatelessWidget {
  final bool free;
  const CourseItem({this.free = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(const CoursePage()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: LocalImage("course".png),
            ),
            Gap.sm,
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Strategic planning for c-suite career.",
                          style: context.textTheme.bodyLarge.size(20),
                          maxLines: 2,
                        ),
                      ),
                      Gap.sm,
                      PriceBadge(free: free)
                    ],
                  ),
                  Gap.md,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.user,
                            size: 18,
                            color: AppColors.palette[500],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: Insets.xs, left: Insets.xs),
                            child: Text(
                              "Jasmine Cole",
                              style: context.textTheme.caption.size(12),
                            ),
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
                            padding: const EdgeInsets.only(
                                top: Insets.xs, left: Insets.xs),
                            child: Text(
                              "1hr 30mins",
                              style: context.textTheme.caption.size(12),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
