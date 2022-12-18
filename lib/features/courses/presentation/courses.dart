import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/price_badge.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/courses/presentation/course.dart';
import 'package:fofo_app/models/course/category.dart';
import 'package:fofo_app/models/course/courses.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/loader.dart';
import '../../../models/course/course.dart';
import '../../../service/course/course.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late final Courses courses;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  getCourses() async {
    courses = await Provider.of<CoursesProvider>(context, listen: false)
        .getCourses(context);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Loader();
    } else {
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
                    categories: courses.categories,
                  ),
                  Gap.lg,
                  const SectionHeader("All courses"),
                  Gap.sm,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CourseItem(
                      course: courses.courses![index],
                    ),
                    itemCount: courses.courses!.length,
                  )
                ],
              ),
            )),
      );
    }
  }
}

class CourseItem extends StatelessWidget {
  final Course course;
  const CourseItem({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(CoursePage(id: course.id)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: NetworkImg(
                course.courseImage.toString(),
                // height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            Gap.sm,
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          course.name,
                          style: context.textTheme.bodyLarge.size(15),
                          maxLines: 2,
                        ),
                      ),
                      Gap.sm,
                      PriceBadge(
                          free: course.accessType == "Free" ? true : false)
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
                            child: course.createdBy!.length > 0
                                ? Text(
                                    course.createdBy![0].fullname.toString(),
                                    style: context.textTheme.caption.size(12),
                                  )
                                : Text(''),
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
                              course.duration.toString(),
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

class CategoryItem extends StatelessWidget {
  final Category? category;
  const CategoryItem({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.smBorder,
          color: AppColors.palette[100],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Insets.xs,
          horizontal: Insets.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: AppColors.palette[300],
            //   ),
            //   child: category['iconName'] == null
            //       ? const Offstage()
            //       : ImageIcon(NetworkImage(category['iconName'])),
            // ),
            // Gap.sm,
            Text(
              category!.name ?? '',
              style: context.textTheme.bodyMedium.size(12),
            )
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String? title;
  final List<Category>? categories;
  final bool seeAll, showTitle;

  const CategorySection(
      {required this.categories,
      this.title,
      this.seeAll = false,
      this.showTitle = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          SectionHeader(title ?? "Categories", seeAll: seeAll),
          Gap.sm,
        ],
        Wrap(
          spacing: Insets.md,
          runSpacing: Insets.sm,
          children: categories!
              .map((category) => CategoryItem(category: category))
              .toList(),
        )
      ],
    );
  }
}
