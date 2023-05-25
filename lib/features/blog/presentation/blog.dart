import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/blog_reply.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/loader.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/models/feed/comment.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/notification.dart';
import '../../../models/feed/get_feed_by_id.dart';
import '../../../service/auth_service/auth_provider.dart';
import '../../../service/feed/feed.dart';

class BlogPage extends StatefulWidget {
  final id;
  const BlogPage({Key? key, required String this.id}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool isLoaded = false;
  late GetFeedById blog;
  late GlobalKey<FormState> formKey;
  var _controller = TextEditingController();

  getBlog() async {
    EasyLoading.show(status: 'loadings...');
    blog = await Provider.of<FeedsProvider>(context, listen: false)
        .getBlog(context, widget.id);
    EasyLoading.dismiss();
    setState(() {
      isLoaded = true;
    });
  }

  postComment(comment) async {
    EasyLoading.show(status: 'loadings...');
    Comment index = await Provider.of<FeedsProvider>(context, listen: false)
        .postComment(context, widget.id, comment);
    _controller.clear();
    setState(() {
      blog.blogComments!.insert(0, index);
    });
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    getBlog();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    late String comment;
    const bottomOffset = 90.0;

    final authProvider = Provider.of<AuthProvider>(context);

    final profile = authProvider.userProfile;

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
              // Row(
              //   children: [
              //     const Icon(
              //       PhosphorIcons.flagBanner,
              //       size: 15,
              //     ),
              //     Gap.xs,
              //     Text(
              //       "Report this post",
              //       style: context.textTheme.caption.size(12),
              //     )
              //   ],
              // ),
              // Gap.sm,
              Row(
                children: [
                  Avatar(AppColors.error,
                      radius: 20,
                      data: CircleAvatar(
                          backgroundColor: Colors.red,
                          backgroundImage: profile?.profileImage == null
                              ? AssetImage("user".png) as ImageProvider
                              : NetworkImage(profile?.profileImage ?? ""))),
                  Gap.sm,
                  Expanded(
                    child: Form(
                        key: formKey,
                        child: TextInputField(
                          controller: _controller,
                          hintText: "Type in your comment",
                          validator: (value) =>
                              value!.isEmpty ? "Comment field required" : null,
                          onSaved: (value) => comment = value!,
                          suffixIcon: const Icon(
                            PhosphorIcons.paperPlaneTiltFill,
                          ).onTap(() {
                            final form = formKey.currentState!;
                            print('hello world');

                            form.save();
                            print(comment);
                            if (comment.isEmpty) {
                              showNotification(
                                  context, false, "Comment field required");
                            } else {
                              postComment(comment);
                            }
                          }),
                        )),
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
                      blog.blog.name.toString().titleCaseSingle(),
                      style: context.textTheme.headlineMedium.bold
                          .size(24)
                          .changeColor(AppColors.primary),
                    ),
                    Gap.md,
                    if (blog.blog.blogImages!.isNotEmpty &&
                        blog.blog.blogImages![0]['image_url'] != null)
                      // {
                      ClipRRect(
                        borderRadius: Corners.mdBorder,
                        child: NetworkImg(
                          blog.blog.blogImages![0]['image_url'].toString(),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
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
                              data: CircleAvatar(
                                backgroundImage: blog
                                            .blog.createdBy?.profileImage !=
                                        null
                                    ? NetworkImage(
                                        blog.blog.createdBy!.profileImage
                                            .toString(),
                                      )
                                    : AssetImage("user".png) as ImageProvider,
                              ),
                              //   NetworkImg(
                              //       blog.blog.createdBy!.profileImage.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Insets.xs),
                              child: Text(
                                "By " +
                                    blog.blog.createdBy!.fullname
                                        .toString()
                                        .titleCaseSingle(),
                                style: context.textTheme.caption.size(12),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Icon(
                            //   PhosphorIcons.clock,
                            //   size: 18,
                            //   color: AppColors.palette[500],
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: Insets.xs),
                              child: Text(
                                DateFormat.yMMMEd()
                                    .format(DateTime.parse(blog.blog.createdAt))
                                    .toString(),
                                style: context.textTheme.caption.size(12),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap.lg,
                    Text(
                      blog.blog.description.toString().titleCaseSingle(),
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
                    const Icon(
                      PhosphorIcons.chatsCircle,
                      size: IconSizes.sm,
                    ),
                    Gap.xs,
                    Padding(
                      padding: const EdgeInsets.only(top: Insets.xs),
                      child: Text("Comments (${blog.blogComments!.length})"),
                    ),
                    Gap.xs,
                    const Icon(
                      PhosphorIcons.caretDown,
                      size: IconSizes.sm,
                    ),
                  ],
                ),
              ),
              Gap.sm,
              blog.blogComments!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding:
                          const EdgeInsets.symmetric(horizontal: Insets.lg),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ReplyCard(comment: blog.blogComments![index]),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: blog.blogComments!.length,
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
                        'No comments',
                        style: TextStyle(fontSize: 14),
                      ),
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
