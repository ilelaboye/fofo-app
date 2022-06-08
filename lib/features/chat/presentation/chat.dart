import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bottomOffset = 100.0;
    return Scaffold(
      appBar: Appbar(
        title: "",
        titleWidget: Padding(
          padding: const EdgeInsets.only(bottom: Insets.sm, left: Insets.md),
          child: Row(
            children: [
              Avatar(
                AppColors.error,
                radius: 20,
              ),
              Gap.sm,
              Text(
                "Lore",
                style: context.textTheme.bodyMedium.size(15).bold,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.md),
        color: AppColors.scaffold,
        height: bottomOffset,
        width: context.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Avatar(AppColors.error, radius: 20),
            Gap.sm,
            Expanded(
              child: SizedBox(
                height: bottomOffset / 2,
                child: TextInputField(
                  hintText: "Send message",
                  prefix: const Icon(
                    PhosphorIcons.paperclip,
                  ),
                  suffixIcon: const Icon(
                    PhosphorIcons.paperPlaneTiltFill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final msg = messageList[index];
                final currentId = msg.uid;
                String previousId = "", nextId = "";
                if (index != 0) {
                  previousId = messageList[index - 1].uid;
                }
                if (index != messageList.length - 1) {
                  nextId = messageList[index + 1].uid;
                }
                return MessageBubble(
                  msg,
                  hasNext: currentId == nextId,
                  hasPrevious: currentId == previousId,
                );
              },
              itemCount: messageList.length,
            ),
            const Gap(bottomOffset + 50),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool hasNext, hasPrevious;
  final Message message;
  const MessageBubble(this.message,
      {required this.hasNext, required this.hasPrevious, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.message:
        if (message.uid == 'me') {
          return RightMessageBubble(
            message,
            hasNext: hasNext,
            hasPrevious: hasPrevious,
          );
        }
        return LeftMessageBubble(
          message,
          hasNext: hasNext,
          hasPrevious: hasPrevious,
        );
      case MessageType.inChatNotification:
        return InAppNotificationBubble(message);
      default:
        throw Exception("Message type not handled");
    }
  }
}

class LeftMessageBubble extends StatelessWidget {
  final bool hasNext, hasPrevious;
  final Message message;

  const LeftMessageBubble(this.message,
      {required this.hasNext, required this.hasPrevious, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: context.getWidth(0.8)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Insets.md, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.palette[100],
                borderRadius:
                    _borderRadius(hasNext: hasNext, hasPrevious: hasPrevious),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Insets.md, Insets.sm, 45, Insets.sm),
                    child: Text(
                      message.text,
                    ),
                  ),
                  Positioned(
                    bottom: Insets.xs,
                    right: Insets.sm,
                    child: Text(
                      message.timestamp,
                      style: context.textTheme.caption.size(12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RightMessageBubble extends StatelessWidget {
  final bool hasNext, hasPrevious;
  final Message message;

  const RightMessageBubble(this.message,
      {required this.hasNext, required this.hasPrevious, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: <Widget>[
            const Expanded(child: SizedBox()),
            Container(
              constraints: BoxConstraints(maxWidth: context.getWidth(0.8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Insets.md, vertical: 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: _borderRadius(
                      position: "right",
                      hasNext: hasNext,
                      hasPrevious: hasPrevious,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Insets.md, Insets.sm, 45, Insets.sm),
                        child: Text(
                          message.text,
                          style: context.textTheme.bodyMedium
                              .changeColor(Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: Insets.xs,
                        right: Insets.sm,
                        child: Text(
                          message.timestamp,
                          style: context.textTheme.caption
                              .size(12)
                              .changeColor(Colors.white70),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap.xs,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.md),
          child: Text(
            message.read ? "Seen" : "Delivered",
            style: context.textTheme.caption
                .size(11)
                .changeColor(AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class InAppNotificationBubble extends StatelessWidget {
  final Message message;
  const InAppNotificationBubble(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      height: 50,
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: Text(
              message.text,
              style: context.textTheme.caption.size(12),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

BorderRadius _borderRadius({
  String position = "left",
  required bool hasNext,
  required bool hasPrevious,
}) {
  if (!hasNext && !hasPrevious) {
    return const BorderRadius.all(Corners.mdRadius);
  } else if (hasNext && hasPrevious) {
    if (position == 'left') {
      return const BorderRadius.only(
        bottomRight: Corners.mdRadius,
        topRight: Corners.mdRadius,
      );
    }
    return const BorderRadius.only(
      topLeft: Corners.mdRadius,
      bottomLeft: Corners.mdRadius,
    );
  } else if (hasNext && !hasPrevious) {
    return BorderRadius.only(
      bottomRight: position == "left" ? Corners.mdRadius : Radius.zero,
      bottomLeft: position == "left" ? Radius.zero : Corners.mdRadius,
      topRight: Corners.mdRadius,
      topLeft: Corners.mdRadius,
    );
  } else {
    return BorderRadius.only(
      bottomRight: Corners.mdRadius,
      bottomLeft: Corners.mdRadius,
      topRight: position == "left" ? Corners.mdRadius : Radius.zero,
      topLeft: position == "left" ? Radius.zero : Corners.mdRadius,
    );
  }
}

enum MessageType { inChatNotification, message, messageWithPhoto } // ..etc

class Message {
  final String uid;
  final String text;
  final MessageType type;
  final String timestamp;
  final bool read;
  Message({
    required this.uid,
    required this.text,
    required this.timestamp,
    this.type = MessageType.message,
    this.read = true,
  });
}

List<Message> messageList = [
  Message(
    uid: "you",
    text: "Hi I’m Rachel!",
    timestamp: "12:11",
  ),
  Message(
    uid: "you",
    text: "What is your name?",
    timestamp: "12:12",
  ),
  Message(
    uid: "me",
    text: "I’m Daniella",
    timestamp: "12:14",
  ),
  Message(
    uid: "you",
    text: "Good afternoon, Ella",
    timestamp: "10:14",
  ),
  Message(
    uid: "you",
    text:
        "I saw what you posted All the Lorem Ipsum generators on the Internet tend to often repeat predefined chunks",
    timestamp: "1:24",
  ),
  Message(
    uid: "you",
    text: "May be they could share some tips?",
    timestamp: "1:24",
  ),
  Message(
    uid: "me",
    text: "I am up anytime",
    timestamp: "1:24",
  ),
  Message(
    uid: "notification",
    text: "Yesterday, 23 dec",
    timestamp: "1:24",
    type: MessageType.inChatNotification,
  ),
  Message(
    uid: "you",
    text: "Good afternoon, Ella",
    timestamp: "10:14",
  ),
  Message(
    uid: "you",
    text:
        "I saw what you posted All the Lorem Ipsum generators on the Internet tend to often repeat predefined chunks",
    timestamp: "1:24",
  ),
  Message(
    uid: "you",
    text: "May be they could share some tips?",
    timestamp: "1:24",
  ),
  Message(
    uid: "me",
    text: "I am up anytime",
    timestamp: "1:24",
  ),
  Message(
    uid: "you",
    text: "May be they could share some tips?",
    timestamp: "1:24",
  ),
  Message(
    uid: "me",
    text: "May be they could share some tips?",
    timestamp: "1:24",
  ),
  Message(
    uid: "me",
    text:
        "I saw what you posted All the Lorem Ipsum generators on the Internet tend to often repeat predefined chunks",
    timestamp: "1:24",
  ),
  Message(
    uid: "me",
    text: "I am up anytime",
    timestamp: "1:24",
    read: false,
  ),
];
