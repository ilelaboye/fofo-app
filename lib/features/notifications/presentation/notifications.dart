import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Notification',
        hasLeading: false,
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
                labelStyle: context.textTheme.caption,
                labelColor: AppColors.primary,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Mentions"),
                  Tab(text: "Requests"),
                  Tab(text: "Events"),
                ]),
            const Expanded(
                child: TabBarView(children: [
              NotificationSectionList(),
              NotificationSectionList(),
              NotificationSectionList(),
              NotificationSectionList(),
            ]))
          ],
        ),
      ),
    );
  }
}

class NotificationSectionList extends StatelessWidget {
  const NotificationSectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.lg,
        vertical: Insets.md,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const FriendRequestItem(),
            Gap.md,
            const SectionHeader("Today"),
            Gap.md,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const InviteOrReplyOrLikeItem(),
              separatorBuilder: (context, index) =>
                  const Divider(height: Insets.lg),
              itemCount: 3,
            ),
            Gap.md,
            const SectionHeader("This week"),
            Gap.md,
            const DiscoverItem(),
          ],
        ),
      ),
    );
  }
}

class FriendRequestItem extends StatelessWidget {
  const FriendRequestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          AppColors.error,
          radius: 18,
        ),
        Gap.sm,
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Friends request",
              style: context.textTheme.headlineMedium
                  .size(17)
                  .changeColor(AppColors.primary),
            ),
            Gap.xs,
            Text(
              "May be they could share some tips",
              style: context.textTheme.caption.size(13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        const Icon(PhosphorIcons.caretRight)
      ],
    );
  }
}

class InviteOrReplyOrLikeItem extends StatelessWidget {
  const InviteOrReplyOrLikeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          AppColors.error,
          radius: 18,
        ),
        Gap.sm,
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Felicia Daniella replied on your post in the Blk grl community",
              style: context.textTheme.bodyMedium
                  .size(14)
                  .changeColor(AppColors.primary),
            ),
            Gap.xs,
            Text(
              "10:12 PM",
              style: context.textTheme.caption.size(13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
      ],
    );
  }
}

class DiscoverItem extends StatelessWidget {
  const DiscoverItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(Insets.sm),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.palette[100],
          ),
          child: const Icon(PhosphorIcons.squaresFour),
        ),
        Gap.sm,
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Discover",
              style: context.textTheme.headlineMedium
                  .size(17)
                  .changeColor(AppColors.primary),
            ),
            Gap.xs,
            Text(
              "Look at the new community - C-suite  women",
              style: context.textTheme.caption.size(13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        const Icon(PhosphorIcons.caretRight)
      ],
    );
  }
}
