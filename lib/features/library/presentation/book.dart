import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/loader.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/notification.dart';
import '../../../service/library/my_library_provider.dart';
import 'library.dart';

class BookPage extends StatefulWidget {
  final id;
  const BookPage({Key? key, required String this.id}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  bool isLoaded = false;
  bool isLoading = false;
  late Map book;
  late Map books;
  // late Book book;

  @override
  void initState() {
    super.initState();
    print(widget.id);
    getBook();
  }

  getBook() async {
    book = await Provider.of<LibraryProvider>(context, listen: false)
        .getBook(context, widget.id);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Loader();
    } else {
      books = Provider.of<LibraryProvider>(context).books;
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
                      child: NetworkImg(
                        book['bookImage'],
                        height: 250,
                      ),
                    ),
                    Gap.md,
                    Text(
                      book['title'],
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
                                "by " + book['author'] + " • ",
                                style: context.textTheme.caption.size(12),
                              ),
                            ),
                            ...List.generate(
                              5,
                              (index) => Padding(
                                  padding: EdgeInsets.only(right: 2),
                                  child: index < book['ratings']
                                      ? Icon(
                                          PhosphorIcons.starFill,
                                          size: 14,
                                          color: Colors.yellow,
                                        )
                                      : Icon(
                                          PhosphorIcons.star,
                                          size: 14,
                                          color: Colors.yellow,
                                        )),
                            ),
                            Text(
                              "(${book['ratings']}/5)",
                              style: context.textTheme.caption
                                  .size(12)
                                  .changeColor(AppColors.primary),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap.md,
                    // Text(
                    //   "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words whichdon't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't any thing embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet to repeat predefined chunks as necessary, making this the  first true generator on the Internet. It uses a dictionary of  over 200 Latin words, combined with a handful of model  sentence structures, to generate Lorem Ipsum which looks  reasonable... show less",
                    //   style: context.textTheme.caption
                    //       .size(12)
                    //       .copyWith(height: 1.8),
                    // ),
                  ],
                ),
              ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Who read"),
              ),
              Gap.sm,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                child: AvatarGroup(
                  AppColors.colorList(),
                  showCount: book['readers'].length,
                ),
              ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Reviews"),
              ),
              Gap.sm,
              const ReviewList(),
              Gap.lg,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Similar Books", seeAll: true,
                    onClickSeeAll: () {
                  context.push(LibraryPage());
                }),
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
                      right: index == books['books'].length - 1 ? Insets.lg : 0,
                    ),
                    child: LibraryItem(books['books'][index]).onTap(() =>
                        context
                            .push(BookPage(id: books['books'][index]['id']))),
                  ),
                  itemCount: books['books'].length,
                ),
              ),
              Gap.lg,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                  child: isLoading
                      ? Loading()
                      : Button("Read This Book", onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final res = await Provider.of<LibraryProvider>(
                                  context,
                                  listen: false)
                              .addBookToLibrary(context, widget.id);
                          setState(() {
                            isLoading = false;
                          });
                          print('retunrs');
                          print(res);
                          if (res['status']) {
                            showNotification(context, true, res['message']);
                          }
                        })),
              const Gap(50)
            ],
          ),
        ),
      );
    }
  }
}
