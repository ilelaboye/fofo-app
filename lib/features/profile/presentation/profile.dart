import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/post_card.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/chat/presentation/chats.dart';
import 'package:fofo_app/features/profile/presentation/edit_profile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends StatelessWidget {
  final bool isCurrentUser;
  const ProfilePage({this.isCurrentUser = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Profile"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push(const ChatsPage()),
        child: const Icon(
          PhosphorIcons.chatsTeardropFill,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.md,
              vertical: Insets.md,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Avatar(AppColors.error, radius: 34),
                    Gap.md,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rachel Choo",
                          style: context.textTheme.bodyMedium.size(17).bold,
                        ),
                        Gap.xs,
                        Row(
                          children: [
                            const Icon(
                              PhosphorIcons.mapPinLight,
                              size: 15,
                            ),
                            Gap.xs,
                            Text(
                              "New York",
                              style: context.textTheme.caption.size(12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Gap.md,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: "Posts\n"),
                        TextSpan(
                          text: "20",
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: "Followers\n"),
                        TextSpan(
                          text: "10k",
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: "Following\n"),
                        TextSpan(
                          text: "2,500",
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                if (isCurrentUser) ...[
                  Gap.md,
                  Button(
                    "Edit Profile",
                    onTap: () => context.push(const EditProfilePage()),
                  ),
                  Gap.lg,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About",
                        style: context.textTheme.headlineMedium
                            .changeColor(AppColors.primary)
                            .size(18)
                            .bold,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Edit About"),
                          Gap.sm,
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.5),
                            child: Icon(
                              PhosphorIcons.arrowRight,
                              size: 18,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
                Gap.md,
                Text(
                  "Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success. We’ll help you and clarify your purpose, overcome impostor syndr see more...",
                  style:
                      context.textTheme.caption.size(13).copyWith(height: 1.4),
                ),
                Gap.md,
                if (!isCurrentUser)
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                            child: Button(
                          "Connect",
                          color: Colors.white,
                          textColor: AppColors.primary,
                          onTap: () => context
                              .push(const ProfilePage(isCurrentUser: true)),
                        )),
                        Gap.sm,
                        Expanded(
                            child: Button(
                          "Follow",
                          onTap: () => context
                              .push(const ProfilePage(isCurrentUser: true)),
                        )),
                      ],
                    ),
                  )
              ],
            ),
          ),
          Gap.md,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isCurrentUser ? "My Communities" : "Communities",
                  style: context.textTheme.headlineMedium
                      .changeColor(AppColors.primary)
                      .size(18)
                      .bold,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("More communitites"),
                    Gap.sm,
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.5),
                      child: Icon(
                        PhosphorIcons.arrowRight,
                        size: 18,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Gap.sm,
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
                child: const CommnunityCard(),
              ),
              itemCount: 3,
            ),
          ),
          Gap.lg,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.md),
            child: SectionHeader("Membership"),
          ),
          Gap.sm,
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: Insets.md),
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            decoration: const BoxDecoration(
              color: Color(0xff5AA2E8),
              borderRadius: Corners.smBorder,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: "Membership plan\n"),
                    TextSpan(
                        text: "Do It Yourself",
                        style: context.textTheme.bodyMedium
                            .size(24)
                            .changeColor(Colors.white)),
                  ]),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: Insets.md),
                    child: LocalImage("DIY".png))
              ],
            ),
          ),
          Gap.lg,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: SectionHeader(
                isCurrentUser ? "My Recent posts" : "Recent posts"),
          ),
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
          const Gap(80),
        ],
      )),
    );
  }
}

class CommnunityCard extends StatelessWidget {
  const CommnunityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: AppColors.palette[200]!,
          width: 0.7,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Women in Tech",
                style: context.textTheme.bodyMedium
                    .changeColor(AppColors.primary)
                    .size(20)
                    .bold,
                maxLines: 2,
              ),
              Gap.sm,
              Row(
                children: [
                  Avatar(AppColors.error, radius: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: Insets.xs),
                    child: Text(
                      "By Regina Ward",
                      style: context.textTheme.caption.size(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AvatarGroup(
            AppColors.colorList(),
            trailing: Text(
              "People",
              style: context.textTheme.caption.size(10),
            ),
            textStyle: context.textTheme.caption
                .size(10)
                .changeColor(AppColors.primary),
            groupRadius: 12,
            showCount: 4,
            leftPadding: 10,
          )
        ],
      ),
    );
  }
}
