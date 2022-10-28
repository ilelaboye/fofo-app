import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/loader.dart';
import 'package:fofo_app/core/widgets/reply_card.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/feed/feed.dart';

class BlogPage extends StatefulWidget {
  final id;
  const BlogPage({Key? key, required String this.id}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool isLoaded = false;
  late Map blog;

  @override
  void initState() {
    super.initState();
    getBlog();
  }

  getBlog() async {
    blog = await Provider.of<FeedsProvider>(context, listen: false)
        .getBlog(context, widget.id);

    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const bottomOffset = 120.0;
    if (isLoaded) {
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
                    Text("blog category".toString().titleCaseSingle(),
                        style: context.textTheme.caption.size(12)),
                    Gap.xs,
                    Text(
                      blog['title'].toString().titleCaseSingle(),
                      style: context.textTheme.headlineMedium.bold
                          .size(24)
                          .changeColor(AppColors.primary),
                    ),
                    Gap.md,
                    if (blog.containsKey('blogImage'))
                      // {
                      ClipRRect(
                        borderRadius: Corners.mdBorder,
                        child: NetworkImg(
                          blog['blogImage'].toString(),
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                    // },

                    Gap.sm,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Avatar(
                              AppColors.error,
                              radius: 12,
                              data: NetworkImg(blog['author']['profileImage']),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Insets.xs),
                              child: Text(
                                "By " +
                                    blog['author']['fullname']
                                        .toString()
                                        .titleCaseSingle(),
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
                                DateFormat.yMMMEd()
                                        .format(
                                            DateTime.parse(blog['createdAt']))
                                        .toString() +
                                    " " +
                                    DateFormat('HH:mm a')
                                        .format(
                                            DateTime.parse(blog['createdAt']))
                                        .toString(),
                                style: context.textTheme.caption.size(12),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap.lg,
                    // Text(
                    //   "“As a black woman running a business and having a career”",
                    //   style: context.textTheme.headlineMedium
                    //       .changeColor(AppColors.primary)
                    //       .size(18),
                    // ),
                    // Gap.sm,
                    Text(
                      blog['description'].toString().titleCaseSingle(),
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
                  children: [
                    Icon(
                      PhosphorIcons.chatsCircle,
                      size: IconSizes.sm,
                    ),
                    Gap.xs,
                    Padding(
                      padding: EdgeInsets.only(top: Insets.xs),
                      child: Text("Comments (${blog['comments'].length})"),
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
                itemCount: blog['comments'].length,
              ),
              const Gap(bottomOffset + 50),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}
