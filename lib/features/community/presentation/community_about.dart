import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/community/presentation/community.dart';

class CommunityAboutPage extends StatelessWidget {
  const CommunityAboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Blk Grl"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome to the blk grl community."),
            Gap.md,
            const SectionHeader("About"),
            Gap.md,
            Text(
              "Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success. We’ll help you and clarify your purpose, overcome impostor syndr see more...",
              style: context.textTheme.caption.size(13).copyWith(height: 1.4),
            ),
            Gap.md,
            Button("Join This Group",
                onTap: () => context.push(const CommunityPage())),
            Gap.lg,
            const SectionHeader("Members (200)", seeAll: true),
            Gap.md,
            AvatarGroup(AppColors.colorList()),
            Gap.lg,
            const SectionHeader("Admins"),
            Gap.md,
            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    right: Insets.sm,
                  ),
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Avatar(AppColors.colorList()[index]),
                        Gap.xs,
                        Text(
                          "Jane Cole",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption
                              .changeColor(AppColors.primary),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: 2,
              ),
            ),
            Gap.md,
          ],
        ),
      )),
    );
  }
}
