import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Event"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: Corners.mdBorder,
                    child: LocalImage(
                      "course_preview".png,
                      height: 200,
                    ),
                  ),
                  Gap.sm,
                  Text(
                    "Women in Finance Meet-up.",
                    style: context.textTheme.headlineMedium.bold
                        .size(24)
                        .changeColor(AppColors.primary),
                  ),
                  Gap.sm,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Downtown Center NYC",
                        style: context.textTheme.caption.size(12),
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
                              "20th March 2022",
                              style: context.textTheme.caption.size(12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap.md,
                  const SectionHeader("About"),
                  Gap.sm,
                  Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words whichdon't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be... show less",
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                  Gap.lg,
                  Button("Reserve A Seat", onTap: () {})
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Similar Events"),
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
                    // use index == events.length -1
                    right: index == 2 ? Insets.lg : 0,
                  ),
                  child: const SimilarEventCard(),
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

class SimilarEventCard extends StatelessWidget {
  const SimilarEventCard({Key? key}) : super(key: key);

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
          ClipRRect(
            borderRadius: Corners.smBorder,
            child: LocalImage(
              "course_preview".png,
              width: context.width,
              height: 100,
            ),
          ),
          Gap.xs,
          Text(
            "Women in Corporate Meet-up",
            maxLines: 2,
            style: context.textTheme.caption
                .changeColor(AppColors.palette[600]!)
                .size(14)
                .bold,
          ),
          Gap.xs,
          Expanded(
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.pushPinSimple,
                  size: 16,
                  color: AppColors.palette[500],
                ),
                Gap.xs,
                Text(
                  "Downtown Center NYC",
                  style: context.textTheme.caption.size(12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
