import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

import '../../../core/widgets/button.dart';
import '../../../core/widgets/loader.dart';
import '../../../core/widgets/notification.dart';
import '../../../models/course/course.dart';
import '../../../service/course/course.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  Map courses = {};
  bool isLoaded = false;
  String search = '';
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  getCourses({int nextPage = 1}) async {
    EasyLoading.show(status: 'loading...');
    courses = await Provider.of<CoursesProvider>(context, listen: false)
        .getCourses(context);

    EasyLoading.dismiss();
    setState(() {
      isLoaded = true;
    });
  }

  searchCourses() async {
    EasyLoading.show(status: 'loading...');
    var resp = await Provider.of<CoursesProvider>(context, listen: false)
        .searchCourse(context, search);
    if (resp['status']) {
      // print(resp);
      setState(() {
        courses['courses'] = resp['data']['searchedBooks'];
      });
      print(courses['courses']);
    } else {
      showNotification(context, false, resp['message']);
    }

    EasyLoading.dismiss();
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
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Insets.md),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextInputField(
                          hintText: "Titles, authors & topics",
                          prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                          onChanged: (value) => search = value!,
                        ),
                      ),
                      Gap.md,
                      Icon(PhosphorIcons.magnifyingGlassBold).onTap(() {
                        print('pro');
                        print(search);
                        searchCourses();
                      })
                    ],
                  ),
                  Gap.lg,
                  CategorySection(
                    categories: courses['categories']['docs'],
                  ),
                  Gap.lg,
                  const SectionHeader("All courses"),
                  Gap.sm,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CourseItem(
                      course: courses['courses']['docs'][index],
                    ),
                    itemCount: courses['courses']['docs'].length,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      courses['courses']['hasPrevPage']
                          ? Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Insets.md, vertical: 10),
                              child: Button(
                                "Prev",
                                width: 100,
                                height: 40,
                                color: AppColors.grey,
                                onTap: () async => {
                                  EasyLoading.show(status: "Loading"),
                                  await getCourses(
                                      nextPage: courses['courses']['prevPage']),
                                  EasyLoading.dismiss(),
                                  scrollController.animateTo(
                                      //go to top of scroll
                                      0, //scroll offset to go
                                      duration: Duration(
                                          milliseconds:
                                              500), //duration of scroll
                                      curve: Curves.fastOutSlowIn //scroll type
                                      )
                                },
                              ),
                            )
                          : Container(),
                      courses['courses']['hasNextPage']
                          ? Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Insets.md, vertical: 10),
                              child: Button(
                                "Next",
                                width: 100,
                                height: 40,
                                onTap: () async => {
                                  EasyLoading.show(status: "Loading"),
                                  await getCourses(
                                      nextPage: courses['courses']['nextPage']),
                                  EasyLoading.dismiss(),
                                  scrollController.animateTo(
                                      //go to top of scroll
                                      0, //scroll offset to go
                                      duration: Duration(
                                          milliseconds:
                                              500), //duration of scroll
                                      curve: Curves.fastOutSlowIn //scroll type
                                      )
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            )),
      );
    }
  }
}

class CourseItem extends StatelessWidget {
  final Map course;
  const CourseItem({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(CoursePage(id: course['id'])),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Corners.smBorder,
              child: NetworkImg(
                course['courseImage'].toString(),
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
                          course['name'],
                          style: context.textTheme.bodyLarge.size(15),
                          maxLines: 2,
                        ),
                      ),
                      Gap.sm,
                      PriceBadge(
                          free: course['accessType'] == "Free" ? true : false)
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
                            child: course['createdBy'].length > 0
                                ? Text(
                                    course['createdBy'][0]['fullname']
                                        .toString(),
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
                              course['duration'].toString(),
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
  final Map category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

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
            Text(
              category['name'] ?? '',
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
  final List categories;
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
          children: categories
              .map((category) => CategoryItem(category: category))
              .toList(),
        )
      ],
    );
  }
}
