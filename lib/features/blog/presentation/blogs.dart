import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/blog_card.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/blog/presentation/blog.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Blog"),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Column(
              children: [
                TextInputField(
                  hintText: "Titles, authors & topics",
                  prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                ),
                Gap.lg,
                CategorySection(
                    categories: categoryItemsNoIcons(), seeAll: true),
                Gap.lg,
                const SectionHeader("Hot"),
                Gap.sm,
                Container(
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
                              "Career",
                              style: context.textTheme.caption.size(12),
                            ),
                            Gap.xs,
                            Text(
                              "Progressing in career as a black woman",
                              style: context.textTheme.bodyMedium.size(16),
                              maxLines: 2,
                            ),
                            Gap.md,
                            Text(
                              "By Jasmine Cole",
                              style: context.textTheme.caption.size(12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: SectionHeader("Recent", seeAll: true),
          ),
          Gap.sm,
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? Insets.lg : Insets.sm,
                  // use index == blog.length -1
                  right: index == 2 ? Insets.lg : 0,
                ),
                child: const BlogCard()
                    .onTap(() => context.push(const BlogPage())),
              ),
              itemCount: 3,
            ),
          ),
          Gap.lg,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: SectionHeader("Popular", seeAll: true),
          ),
          Gap.sm,
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? Insets.lg : Insets.sm,
                  // use index == blog.length -1
                  right: index == 2 ? Insets.lg : 0,
                ),
                child: const BlogCard()
                    .onTap(() => context.push(const BlogPage())),
              ),
              itemCount: 3,
            ),
          ),
          const Gap(50)
        ],
      )),
    );
  }
}
