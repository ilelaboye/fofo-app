import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/blog/presentation/blogs.dart';
import 'package:fofo_app/features/courses/presentation/courses.dart';
import 'package:fofo_app/features/library/presentation/library.dart';
import 'package:fofo_app/features/podcast/presentation/podcasts.dart';
import 'package:fofo_app/features/profile/presentation/profile.dart';
import 'package:fofo_app/features/shop/presentation/shop.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(0.75),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: Insets.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(64),
                Avatar(
                  AppColors.error,
                  radius: 30,
                ),
                Gap.sm,
                Text(
                  "Rachel Choo",
                  style: context.textTheme.bodyMedium.size(15).bold,
                ),
                Gap.md,
                Row(
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "100 ",
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                        const TextSpan(text: "Following"),
                      ]),
                    ),
                    Gap.sm,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "100 ",
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                        const TextSpan(text: "Followers"),
                      ]),
                    )
                  ],
                ),
                const Divider(height: 27),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    PhosphorIcons.user,
                    size: 27,
                  ),
                  onTap: () {
                    context.pop();
                    context.push(const ProfilePage());
                  },
                  title: Text(
                    "Profile",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    PhosphorIcons.notepad,
                    size: 27,
                  ),
                  onTap: () {
                    context.pop();
                    context.push(const BlogsPage());
                  },
                  title: Text(
                    "Blog",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    PhosphorIcons.youtubeLogo,
                    size: 27,
                  ),
                  onTap: () {
                    context.pop();
                    context.push(const CoursesPage());
                  },
                  title: Text(
                    "Courses",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    PhosphorIcons.books,
                    size: 27,
                  ),
                  onTap: () {
                    context.pop();
                    context.push(const LibraryPage());
                  },
                  title: Text(
                    "Library",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    PhosphorIcons.applePodcastsLogo,
                    size: 27,
                  ),
                  onTap: () {
                    context.pop();
                    context.push(const PodcastsPage());
                  },
                  title: Text(
                    "Podcast",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    PhosphorIcons.storefront,
                    size: 27,
                  ),
                  onTap: () {
                    context.pop();
                    context.push(const ShopPage());
                  },
                  title: Text(
                    "Shop",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                const Divider(height: 27),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Settings",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Terms and Privacy",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Help Center",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                const Divider(height: 27),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    PhosphorIcons.signOut,
                    color: AppColors.error,
                    size: 27,
                  ),
                  title: Text(
                    "Logout",
                    style: context.textTheme.bodyMedium.size(17),
                  ),
                ),
                Gap.lg,
              ],
            ),
          ),
        ),
      ),
    );
  }
}