import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/library/presentation/library.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Book",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: Corners.xsBorder,
                    child: LocalImage(
                      "book1".png,
                      height: 250,
                    ),
                  ),
                  Gap.md,
                  Text(
                    "Don’t make me think: A common sense approach to career path.",
                    style: context.textTheme.headlineMedium.bold
                        .size(24)
                        .changeColor(AppColors.primary),
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
                              "by Krug Steve • ",
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
                    ],
                  ),
                  Gap.md,
                  Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words whichdon't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't any thing embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet to repeat predefined chunks as necessary, making this the  first true generator on the Internet. It uses a dictionary of  over 200 Latin words, combined with a handful of model  sentence structures, to generate Lorem Ipsum which looks  reasonable... show less",
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                ],
              ),
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Who read", seeAll: true),
            ),
            Gap.sm,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: AvatarGroup(AppColors.colorList()),
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Reviews"),
            ),
            Gap.sm,
            const ReviewList(),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Similar Books", seeAll: true),
            ),
            Gap.sm,
            SizedBox(
              height: 180,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    // use index == books.length -1
                    right: index == 2 ? Insets.lg : 0,
                  ),
                  child: LibraryItem("book${++index}".png)
                      .onTap(() => context.push(const BookPage())),
                ),
                itemCount: 3,
              ),
            ),
            Gap.lg,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Button("Read This Book", onTap: () {}),
            ),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}
