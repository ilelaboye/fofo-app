import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/loader.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/blog_card.dart';
import '../../../core/widgets/categories.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/image.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/text_input.dart';
import '../../../models/feed/feeds.dart';
import '../../../service/feed/feed.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  bool isLoaded = false;
  late Feeds blogs;
  @override
  void initState() {
    super.initState();
    getBlogs();
  }

  getBlogs() async {
    print('get blogds');
    EasyLoading.show(status: 'loadings...');
    blogs = await Provider.of<FeedsProvider>(context, listen: false)
        .getFeeds(context);
    setState(() {
      isLoaded = true;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Scaffold(
        appBar: const Appbar(title: "Blogs"),
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
                      categories: categoryItemsNoIcons(), seeAll: false),
                  Gap.lg,
                  const SectionHeader("Hot"),
                  Gap.sm,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (blogs.hot!.blogImages!.isNotEmpty &&
                          blogs.hot!.blogImages![0]['image_url'] != null)
                        ClipRRect(
                          borderRadius: Corners.smBorder,
                          child: NetworkImg(
                            blogs.hot!.blogImages![0]['image_url'].toString(),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      Gap.sm,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blogs.hot!.blogCategory == null
                                  ? ""
                                  : blogs.hot!.blogCategory!.name
                                      .toString()
                                      .titleCaseSingle(),
                              style: context.textTheme.caption.size(12),
                            ),
                            Gap.xs,
                            Text(
                              blogs.hot!.name.toString().titleCaseSingle(),
                              style: context.textTheme.bodyMedium.size(16),
                              maxLines: 2,
                            ),
                            Gap.md,
                            Text(
                              "By " + blogs.hot!.createdBy!.fullname.toString(),
                              style: context.textTheme.caption.size(12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  // Column(children: [
                  //   ...blogs.blogs.map(
                  //     (item) => Container(
                  //       padding:
                  //           const EdgeInsets.symmetric(vertical: Insets.sm),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           if (item.blogImage != null)
                  //             ClipRRect(
                  //               borderRadius: Corners.smBorder,
                  //               child: NetworkImg(
                  //                 item.blogImage.toString(),
                  //                 width: 100,
                  //                 height: 100,
                  //               ),
                  //             ),
                  //           Gap.sm,
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   item.blogCategory!.name
                  //                       .toString()
                  //                       .titleCaseSingle(),
                  //                   style: context.textTheme.caption.size(12),
                  //                 ),
                  //                 Gap.xs,
                  //                 Text(
                  //                   item.title.toString().titleCaseSingle(),
                  //                   style:
                  //                       context.textTheme.bodyMedium.size(16),
                  //                   maxLines: 2,
                  //                 ),
                  //                 Gap.md,
                  //                 Text(
                  //                   "By " + item.createdBy!.fullname.toString(),
                  //                   style: context.textTheme.caption.size(12),
                  //                 )
                  //               ],
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ])
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Recent", seeAll: false),
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
                    right: index == blogs.recent!.length - 1 ? Insets.lg : 0,
                  ),
                  child: BlogCard(feed: blogs.recent![index]),
                ),
                itemCount: blogs.recent!.length,
              ),
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Popular", seeAll: false),
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
                      right: index == blogs.popular!.length - 1 ? Insets.lg : 0,
                    ),
                    child: BlogCard(feed: blogs.popular![index])),
                itemCount: blogs.popular!.length,
              ),
            ),
            const Gap(50)
          ],
        )),
      );
    } else {
      return const Loader();
    }
  }
}
