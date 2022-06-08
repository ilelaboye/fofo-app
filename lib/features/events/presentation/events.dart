import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/events/presentation/event.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Events",
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Column(
              children: [
                TextInputField(
                  hintText: "Search for events",
                  prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                ),
                Gap.lg,
                const SectionHeader("New"),
                Gap.sm,
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: Corners.mdBorder,
                      child: LocalImage(
                        "course_preview".png,
                        height: 160,
                        width: context.width,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: context.width,
                      decoration: const BoxDecoration(
                          borderRadius: Corners.mdBorder,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.black26,
                                Colors.transparent,
                              ])),
                    ),
                    Positioned(
                      bottom: Insets.lg,
                      right: context.width / 3,
                      left: Insets.md,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Trailblazer Femme Meetup.",
                            style: context.textTheme.bodyMedium.bold
                                .size(20)
                                .changeColor(Colors.white),
                          ),
                          Gap.xs,
                          Text(
                            "New York City, USA",
                            style: context.textTheme.caption
                                .size(12)
                                .changeColor(AppColors.palette[400])
                                .bold,
                          ),
                          Gap.md,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "See Details",
                                style: context.textTheme.caption
                                    .size(14)
                                    .changeColor(AppColors.palette[100])
                                    .bold,
                              ),
                              Gap.sm,
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.5),
                                child: Icon(
                                  PhosphorIcons.arrowRightBold,
                                  size: 20,
                                  color: AppColors.palette[400],
                                ),
                              )
                            ],
                          ).onTap(
                            () => context.push(const EventPage()),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Gap.lg,
                const SectionHeader("Upcoming", seeAll: true),
                Gap.sm,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => const EventItem(),
                  itemCount: 7,
                ),
                Gap.lg,
              ],
            ),
          )),
    );
  }
}

class EventItem extends StatelessWidget {
  const EventItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(const EventPage()),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Women in Finance Meet-up",
                    style: context.textTheme.bodyMedium.size(16),
                    maxLines: 2,
                  ),
                  Gap.xs,
                  Text(
                    "Downtown Center NYC",
                    style: context.textTheme.caption.size(12),
                  ),
                  Gap.md,
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
                          "20th March 2022",
                          style: context.textTheme.caption.size(12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
