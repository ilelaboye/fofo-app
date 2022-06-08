import 'package:flutter/material.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/reply_card.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bottomOffset = 120.0;
    return Scaffold(
      appBar: const Appbar(title: "Blog"),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.md,
          vertical: Insets.md,
        ),
        color: AppColors.scaffold,
        height: bottomOffset,
        width: context.width,
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  PhosphorIcons.flagBanner,
                  size: 15,
                ),
                Gap.xs,
                Text(
                  "Report this post",
                  style: context.textTheme.caption.size(12),
                )
              ],
            ),
            Gap.sm,
            Row(
              children: [
                Avatar(AppColors.error, radius: 20),
                Gap.sm,
                Expanded(
                  child: TextInputField(
                    hintText: "Type in your comment",
                    suffixIcon: const Icon(
                      PhosphorIcons.paperPlaneTiltFill,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Career", style: context.textTheme.caption.size(12)),
                  Gap.xs,
                  Text(
                    "Progressing in career as a black woman",
                    style: context.textTheme.headlineMedium.bold
                        .size(24)
                        .changeColor(AppColors.primary),
                  ),
                  Gap.md,
                  ClipRRect(
                    borderRadius: Corners.mdBorder,
                    child: LocalImage(
                      "course_preview".png,
                      height: 200,
                    ),
                  ),
                  Gap.sm,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Avatar(AppColors.error, radius: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: Insets.xs),
                            child: Text(
                              "By Jasmine Cole",
                              style: context.textTheme.caption.size(12),
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
                              "20th May 2022",
                              style: context.textTheme.caption.size(12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap.lg,
                  Text(
                    "“As a black woman running a business and having a career”",
                    style: context.textTheme.headlineMedium
                        .changeColor(AppColors.primary)
                        .size(18),
                  ),
                  Gap.sm,
                  Text(
                    "There are many variations of passages of Lorem Ipsum dole available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to often repeat predefined chunks as necessary, making this the first",
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Row(
                children: const [
                  Icon(
                    PhosphorIcons.chatsCircle,
                    size: IconSizes.sm,
                  ),
                  Gap.xs,
                  Padding(
                    padding: EdgeInsets.only(top: Insets.xs),
                    child: Text("Comments (2)"),
                  ),
                  Gap.xs,
                  Icon(
                    PhosphorIcons.caretDown,
                    size: IconSizes.sm,
                  ),
                ],
              ),
            ),
            Gap.sm,
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ReplyCard.comment(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 2,
            ),
            const Gap(bottomOffset + 50),
          ],
        ),
      ),
    );
  }
}
