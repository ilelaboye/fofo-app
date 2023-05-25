import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:fofo_app/models/library/my_library/book.dart';
import 'package:fofo_app/service/library/my_library_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/library/my_library/my_library.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  // late final List<Book> books;
  MyLibrary? library;
  bool loaded = false;
  // final libraryProvider = Provider.of<LibraryProvider>(context);
  @override
  void initState() {
    super.initState();
    getLibrary();
  }

  getLibrary() async {
    EasyLoading.show(status: "Loading...");
    library = await Provider.of<LibraryProvider>(context, listen: false)
        .getLibrary(context);
    setState(() {
      loaded = true;
    });
    EasyLoading.dismiss();
    print('pbookd');
    print(library);
  }

  @override
  Widget build(BuildContext context) {
    print('library page');
    // print(library);
    if (loaded) {
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
                      categories: library?.categories ?? [],
                    ),
                    Gap.lg,
                    const SectionHeader("Continue Reading"),
                    Gap.sm,
                    library!.continue_reading != null
                        ? Container(
                            height: 150,
                            padding: const EdgeInsets.all(Insets.md),
                            decoration: BoxDecoration(
                              color: AppColors.palette[100],
                              borderRadius: Corners.smBorder,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  child: NetworkImg(
                                    library!.continue_reading!.bookImage
                                        .toString(),
                                    height: 150,
                                    width: 110,
                                  ),
                                ),
                                Gap.md,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        library!.continue_reading!.name
                                            .toString(),
                                      ),
                                      Gap.md,
                                      Text(
                                        "by " +
                                            library!.continue_reading!.author!
                                                .fullname
                                                .toString(),
                                        style:
                                            context.textTheme.caption.size(13),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ).onTap(() => context.push(BookPage(
                            id: library!.continue_reading!.id.toString())))
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 13, horizontal: 13),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xff0f1dcb9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            child: const Text(
                              'No available book',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("My Library"),
              ),
              Gap.sm,
              library!.books_in_library!.length > 0
                  ? SizedBox(
                      height: 180,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? Insets.lg : Insets.sm,
                            // use index == books.length -1
                            right:
                                index == library!.books_in_library!.length - 1
                                    ? Insets.lg
                                    : 0,
                          ),
                          child: LibraryItem(library!.books_in_library![index])
                              .onTap(() => context.push(BookPage(
                                  id: library!.books_in_library![index].id
                                      .toString()))),
                        ),
                        itemCount: library?.books_in_library!.length,
                      ),
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
                        'No books available',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Trending Books"),
              ),
              Gap.sm,
              library!.trending_books!.length > 0
                  ? SizedBox(
                      height: 180,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? Insets.lg : Insets.sm,
                            // use index == books.length -1
                            right: index == library!.trending_books!.length - 1
                                ? Insets.lg
                                : 0,
                          ),
                          child: LibraryItem(library!.trending_books![index])
                              .onTap(() => context.push(BookPage(
                                  id: library!.trending_books![index].id
                                      .toString()))),
                        ),
                        itemCount: library!.trending_books!.length,
                      ),
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
                        'No trending books available',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Top Authors", seeAll: false),
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
                      right: index == library!.top_authors!.length - 1
                          ? Insets.lg
                          : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Avatar(
                          AppColors.colorList()[index],
                          // radius: 10,
                          data: CircleAvatar(
                            backgroundImage: NetworkImage(
                              library!.top_authors![index].image_url.toString(),
                            ),
                          ),
                        ).onTap(
                          () => context.push(
                            SingleAuthorBooksPage(
                                author: library!.top_authors![index]),
                          ),
                        ),
                        Text(
                          library!.top_authors![index].fullname.toString(),
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                  itemCount: library!.top_authors!.length,
                ),
              ),
              const Gap(50)
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class LibraryItem extends StatelessWidget {
  final Book book;
  const LibraryItem(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: Corners.smBorder,
          child: NetworkImg(
            book.bookImage.toString(),
            height: 150,
            width: 110,
          ),
        ),
        Gap.sm,
        SizedBox(
            width: 120,
            child: Text(
              book.name.toString(),
              maxLines: 1,
            ))
      ],
    );
  }
}
