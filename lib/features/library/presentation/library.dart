import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/loader.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/library/presentation/book.dart';
import 'package:fofo_app/features/library/presentation/single_author_list.dart';
import 'package:fofo_app/models/library/my_library/book.dart';
import 'package:fofo_app/service/library/my_library_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  // late final List<Book> books;
  late final books;
  bool isLoaded = true;
  @override
  void initState() {
    super.initState();
    // getBooks();
    // getLibrary();
  }

  // getBooks() async {
  //   books = await Provider.of<LibraryProvider>(context, listen: false)
  //       .getBooks(context);
  //   print('pbookd');
  //   print(books);
  //   setState(() {
  //     isLoaded = true;
  //   });
  // }

  // getLibrary() async {
  //   books = await Provider.of<LibraryProvider>(context, listen: false)
  //       .getBooks(context);
  //   print('pbookd');
  //   print(books);
  //   setState(() {
  //     isLoaded = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Loader();
    } else {
      final libraryProvider = Provider.of<LibraryProvider>(context);
      print('my lib');
      print(libraryProvider.myLibrary);
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
                            child: NetworkImg(
                              libraryProvider
                                  .myLibrary!.continue_reading!.bookImage
                                  .toString(),
                              height: 150,
                              width: 110,
                            ),
                          ),
                          Gap.md,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  libraryProvider
                                      .myLibrary!.continue_reading!.name
                                      .toString(),
                                ),
                                Gap.md,
                                Text(
                                  "by " +
                                      libraryProvider.myLibrary!
                                          .continue_reading!.author!.fullname
                                          .toString(),
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
                child: SectionHeader("My Library"),
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
                      right: index ==
                              libraryProvider
                                      .myLibrary!.books_in_library!.length -
                                  1
                          ? Insets.lg
                          : 0,
                    ),
                    child: LibraryItem(
                            libraryProvider.myLibrary!.books_in_library![index])
                        .onTap(() => context
                            .push(BookPage(id: books['books'][index].id))),
                  ),
                  itemCount:
                      libraryProvider.myLibrary?.books_in_library!.length,
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
                      right: index ==
                              libraryProvider
                                      .myLibrary!.trending_books!.length -
                                  1
                          ? Insets.lg
                          : 0,
                    ),
                    child: LibraryItem(
                            libraryProvider.myLibrary!.trending_books![index])
                        .onTap(() => context.push(BookPage(
                            id: libraryProvider
                                .myLibrary!.trending_books![index].id
                                .toString()))),
                  ),
                  itemCount: libraryProvider.myLibrary!.trending_books!.length,
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
                      right: index ==
                              libraryProvider.myLibrary!.top_authors!.length - 1
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
                              libraryProvider
                                  .myLibrary!.top_authors![index].image_url
                                  .toString(),
                            ),
                          ),
                        ).onTap(
                          () => context.push(
                            SingleAuthorBooksPage(
                                author: libraryProvider
                                    .myLibrary!.top_authors![index]),
                          ),
                        ),
                        Text(
                          libraryProvider
                              .myLibrary!.top_authors![index].fullname
                              .toString(),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  itemCount: libraryProvider.myLibrary!.top_authors!.length,
                ),
              ),
              const Gap(50)
            ],
          ),
        ),
      );
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
