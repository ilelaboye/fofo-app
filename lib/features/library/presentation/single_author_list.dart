import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/models/library/my_library/top_author.dart';

class SingleAuthorBooksPage extends StatefulWidget {
  final TopAuthor author;
  const SingleAuthorBooksPage({Key? key, required this.author})
      : super(key: key);

  @override
  State<SingleAuthorBooksPage> createState() => _SingleAuthorBooksPageState();
}

class _SingleAuthorBooksPageState extends State<SingleAuthorBooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: widget.author.id.toString(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Showing results books: " +
                  widget.author.totalBooksWritten.toString()),
              Gap.md,
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) => BookItem(
              //       "book${index + 1}".png,
              //       widget.author.books![index],
              //       widget.author.id),
              //   itemCount: widget.author.books!.length,
              // ),
              const Gap(50)
            ],
          ),
        ),
      ),
    );
  }
}
