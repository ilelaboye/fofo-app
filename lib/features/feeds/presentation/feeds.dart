import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/blog_card.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/create_post.dart';
import 'package:fofo_app/core/widgets/post_card.dart';
import 'package:fofo_app/models/profile/user_profile/user_profile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service/auth_provider.dart';
import '../../../service/profile_service/profile_provider.dart';

class FeedsPage extends StatelessWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final profile = authProvider.userProfile;
    return Scaffold(
      appBar: Appbar(
        leading: Avatar(AppColors.error,
            data: CircleAvatar(
              backgroundColor: Colors.red,
              // backgroundImage: NetworkImage(profile?.profileImage ?? "")
            )).onTap(() => AppScaffoldPage.of(context).openDrawer()),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push(const CreatePostPage()),
        heroTag: ValueKey(DateTime.now()), // for dev
        child: const Icon(
          PhosphorIcons.plus,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(
                hasImage: true,
              ),
            ),
            Gap.md,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.md),
              child: SectionHeader(
                "Blog",
                seeAll: true,
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
                    right: index == 2 ? Insets.md : 0,
                  ),
                  child: const BlogCard(),
                ),
                itemCount: 3,
              ),
            ),
            Gap.md,
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(
                hasReplies: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.md, vertical: Insets.xs),
              child: PostCard(),
            ),
            const Gap(80),
          ],
        ),
      ),
    );
  }
}
