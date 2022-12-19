import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/chat/presentation/chats.dart';
import 'package:fofo_app/features/profile/presentation/edit_profile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  final bool isCurrentUser;
  const ProfilePage({this.isCurrentUser = false, Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final profile = authProvider.userProfile!;
    print('get profile');
    print(profile);

    void getProfile() {
      print('get profile api');
      final getP = authProvider.getUserProfile(context, '');
      print(getP);
    }

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
                    Avatar(AppColors.colorList()[1],
                        data: CircleAvatar(
                            backgroundImage:
                                NetworkImage(profile.profileImage.toString()))),
                    Gap.md,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.fullname ?? "",
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
                        const TextSpan(text: "Books read\n"),
                        TextSpan(
                          text: profile.booksRead.toString(),
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: "Followers\n"),
                        TextSpan(
                          text: profile.followers.toString(),
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: "Following\n"),
                        TextSpan(
                          text: profile.following.toString(),
                          style: context.textTheme.bodyMedium.size(15).bold,
                        ),
                      ]),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                if (widget.isCurrentUser) ...[
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
                if (!widget.isCurrentUser)
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
                  widget.isCurrentUser ? "My Communities" : "Communities",
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
                        text: profile.membershipType != null ? 'Paid' : 'Free',
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
