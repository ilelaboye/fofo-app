import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/mentor/presentation/mentor_matching.dart';

class MentorPage extends StatelessWidget {
  const MentorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Mentor Matching"),
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
              "Mentor Matching",
              style: context.textTheme.headlineSmall.bold
                  .changeColor(AppColors.primary),
            ),
            Gap.sm,
            Text(
              "You do not have any mentors at the moment, when you get matched with Mentors, they will appear here, in the mean time click to find mentors",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium
                  .changeColor(AppColors.palette[600])
                  .copyWith(height: 1.8),
            ),
            Gap.lg,
            Button(
              "Find Mentors",
              onTap: () => context.push(const MentorMatchingPage()),
            )
          ],
        ),
      ),
    );
  }
}
