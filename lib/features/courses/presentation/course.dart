import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/course_review.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/price_badge.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/loader.dart';
import '../../../models/course/course.dart';
import '../../../models/course/get_course_by_id.dart';
import '../../../service/course/course.dart';

class CoursePage extends StatefulWidget {
  final id;
  const CoursePage({Key? key, required String this.id}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  bool isLoaded = false;
  late GetCourseById course;

  @override
  void initState() {
    super.initState();
    getCourse();
  }

  getCourse() async {
    print('init courxe');
    course = await Provider.of<CoursesProvider>(context, listen: false)
        .getCourse(context, widget.id);
    EasyLoading.dismiss();
    print('single course');
    print(course);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
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
                      course.course.name,
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
                          child: NetworkImg(
                            course.course.courseImage.toString(),
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
                              filter:
                                  ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
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
                              child: course.course.createdBy!.length > 0
                                  ? Text(
                                      "by " +
                                          course.course.createdBy![0].fullname
                                              .toString() +
                                          " • ",
                                      style: context.textTheme.caption.size(12),
                                    )
                                  : Text(''),
                            ),
                            ...List.generate(
                              5,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: index < course.course.ratings_avg
                                    ? Icon(
                                        PhosphorIcons.starFill,
                                        size: 14,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        PhosphorIcons.star,
                                        size: 14,
                                        color: AppColors.primary,
                                      ),
                              ),
                            ),
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
                                course.course.duration.toString(),
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
                        PriceBadge(
                            free: course.course.accessType == "Free"
                                ? true
                                : false)
                      ],
                    ),
                    Gap.sm,
                    Text(
                      course.course.description.toString(),
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
                height: 85,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.lg : Insets.sm,
                      // use index == tutors.length -1
                      right: index == course.course.createdBy!.length - 1
                          ? Insets.lg
                          : 0,
                    ),
                    child: Column(
                      children: [
                        Avatar(
                          AppColors.colorList()[index],
                          data: CircleAvatar(
                              backgroundImage: NetworkImage(course
                                  .course.createdBy![index].image_url
                                  .toString())),
                        ),
                        Gap.xs,
                        SizedBox(
                          width: 70,
                          child: Text(
                            course.course.createdBy![index].fullname,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.caption
                                .changeColor(AppColors.primary),
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: course.course.createdBy!.length,
                ),
              ),
              Gap.md,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Reviews"),
              ),
              Gap.sm,
              course.course_reviews.length > 0
                  ? CourseReviewList(
                      reviews: course.course_reviews,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: Insets.lg),
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xff0f1dcb9),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: const Text(
                        'No reviews',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
              Gap.md,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Similar Courses", seeAll: false),
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
                      right: index == course.similar.length - 1 ? Insets.lg : 0,
                    ),
                    child: SimilarCourseCard(
                      course: course.similar[index],
                    ),
                  ),
                  itemCount: course.similar.length,
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}

class SimilarCourseCard extends StatelessWidget {
  final Course course;
  const SimilarCourseCard({Key? key, required this.course}) : super(key: key);

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
                child: NetworkImg(
                  course.courseImage.toString(),
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
                        free: course.accessType == "Free" ? true : false),
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
                            course.duration.toString(),
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
          Flexible(
            child: Text(
              course.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.caption
                  .changeColor(AppColors.palette[600]!)
                  .size(14)
                  .bold,
            ),
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
              Flexible(
                child: Text(
                  course.createdBy!.fold('', (a, b) => a + ", " + b.fullname),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall
                      .changeColor(AppColors.palette[600]!),
                ),
              ),
            ],
          )
        ],
      ),
    ).onTap(() {
      context.push(CoursePage(id: course.id));
    });
  }
}
