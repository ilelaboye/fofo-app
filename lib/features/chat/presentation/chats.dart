import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/chat/presentation/chat.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: "Messages",
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                PhosphorIcons.plus,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              TextInputField(
                hintText: "Search using name",
                prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
              ),
              Gap.lg,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(
                  height: Insets.lg,
                ),
                itemBuilder: (context, index) => ChatListItem(
                  unreadCount: (index % 2) == 0 ? 1 : 0,
                ).onTap(
                  () => context.push(const ChatPage()),
                ),
                itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final int unreadCount;
  const ChatListItem({required this.unreadCount, Key? key}) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Regina Arnold",
                  style: context.textTheme.headlineMedium
                      .size(17)
                      .changeColor(AppColors.primary),
                ),
                Text(
                  "10:22",
                  style: context.textTheme.caption.size(12),
                )
              ],
            ),
            Gap.xs,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.xs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "May be they could share some tips",
                      style: context.textTheme.caption.size(13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (unreadCount != 0)
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Color(0xff3B9B7B), shape: BoxShape.circle),
                      child: Text(
                        "$unreadCount",
                        style:
                            context.textTheme.caption.changeColor(Colors.white),
                      ),
                    )
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
