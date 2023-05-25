import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../core/presentation/app/app_scaffold.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/avatar_group.dart';
import '../../../core/widgets/blog_card.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/image.dart';
import '../../../core/widgets/post.dart';
import '../../../core/widgets/section_header.dart';
import '../../../models/feed/feeds.dart';
import '../../../service/auth_service/auth_provider.dart';
import '../../../service/feed/feed.dart';
import '../../blog/presentation/blogs.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  late final Feeds feeds;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getFeeds();
  }

  getFeeds() async {
    EasyLoading.show(status: 'loading...');
    feeds = await Provider.of<FeedsProvider>(context, listen: false)
        .getFeeds(context);
    print('print feeds');
    print(feeds);
    EasyLoading.dismiss();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("feeds page");
    final authProvider = Provider.of<AuthProvider>(context);

    final profile = authProvider.userProfile;

    if (!isLoaded) {
      return Container();
    } else {
      return Scaffold(
        appBar: Appbar(
          leading: Avatar(AppColors.error,
                  data: CircleAvatar(
                      backgroundColor: Colors.red,
                      backgroundImage: profile?.profileImage == null
                          ? AssetImage("user".png) as ImageProvider
                          : NetworkImage(profile?.profileImage ?? "")))
              .onTap(() => AppScaffoldPage.of(context).openDrawer()),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: Insets.md),
                child: LocalImage(
                  "logo".png,
                  height: 37,
                ),
              ),
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.primary,
        //   onPressed: () => context.push(const CreatePostPage()),
        //   heroTag: ValueKey(DateTime.now()), // for dev
        //   child: const Icon(
        //     PhosphorIcons.plus,
        //     color: Colors.white,
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // feeds.map((e) => null)
              ...feeds.popular!.take(2).map(
                    (item) => Container(
                      margin: const EdgeInsets.symmetric(vertical: Insets.md),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Insets.md, vertical: Insets.xs),
                        child: PostCard(
                          feed: item,
                        ),
                      ),
                    ),
                  ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.md),
                child: SectionHeader(
                  "Just Joined",
                  seeAll: true,
                ),
              ),
              Gap.md,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => Avatar(AppColors.colorList()[index]),
                  ),
                ),
              ),
              Gap.md,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.md),
                child: SectionHeader(
                  "Blog",
                  seeAll: true,
                  onClickSeeAll: () => context.push(const BlogsPage()),
                ),
              ),
              Gap.md,
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.md : Insets.sm,
                      // use index == blog.length -1
                      right: index == feeds.recent!.length - 1 ? Insets.md : 0,
                    ),
                    child: BlogCard(feed: feeds.recent![index]),
                  ),
                  itemCount: feeds.recent!.length,
                ),
              ),
              Gap.md,
              ...feeds.popular!.skip(2).map(
                    (item) => Container(
                      margin: const EdgeInsets.symmetric(vertical: Insets.md),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Insets.md, vertical: Insets.xs),
                        child: PostCard(
                          feed: item,
                        ),
                      ),
                    ),
                  ),
              const Gap(80),
            ],
          ),
        ),
      );
    }
  }
}
