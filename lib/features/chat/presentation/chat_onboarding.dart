import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/chat/presentation/chats.dart';

class ChatOnboardingPage extends StatelessWidget {
  const ChatOnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Message Box",
        hasLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LocalImage(
              "vector1".png,
              height: 150,
            ),
            Gap.lg,
            Text(
              "Instant message box",
              style: context.textTheme.headlineSmall.bold
                  .changeColor(AppColors.primary),
            ),
            Gap.sm,
            Text(
              "Explore the community and make some new contacts to start conversing",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium
                  .changeColor(AppColors.palette[600])
                  .copyWith(height: 1.8),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Button(
                "Message",
                onTap: () => context.push(const ChatsPage()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
