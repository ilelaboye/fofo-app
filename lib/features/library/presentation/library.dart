import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/library/presentation/book.dart';
import 'package:fofo_app/features/library/presentation/single_author_list.dart';
import 'package:fofo_app/service/library/my_library_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service/auth_provider.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final libraryProvider = Provider.of<LibraryProvider>(context);
    return Scaffold(
      appBar: const Appbar(
        title: "Library",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    categories: libraryProvider.myLibrary?.categories ?? [],
                  ),
                  Gap.lg,
                  const SectionHeader("Continue Reading"),
                  Gap.sm,
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(Insets.md),
                    decoration: BoxDecoration(
                      color: AppColors.palette[100],
                      borderRadius: Corners.smBorder,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          child: LocalImage("book1".png),
                        ),
                        Gap.md,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Don’t make me think: A common sense approach to career path.",
                              ),
                              Gap.md,
                              Text(
                                "by Krug Steve",
                                style: context.textTheme.caption.size(13),
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
              child: SectionHeader("My Library", seeAll: true),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Trending Books", seeAll: true),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Top Authors", seeAll: true),
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
                    // use index == authors.length -1
                    right: index == 9 ? Insets.lg : 0,
                  ),
                  child: Avatar(
                    AppColors.colorList()[index],
                  ).onTap(
                    () => context.push(
                      const SingleAuthorBooksPage(),
                    ),
                  ),
                ),
                itemCount: 10,
              ),
            ),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}

class LibraryItem extends StatelessWidget {
  final String imgUrl;
  const LibraryItem(this.imgUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: Corners.smBorder,
          child: LocalImage(
            imgUrl,
            height: 150,
            width: 110,
          ),
        ),
        Gap.sm,
        const SizedBox(
            width: 120,
            child: Text(
              "Tips And Tricks",
              maxLines: 1,
            ))
      ],
    );
  }
}
