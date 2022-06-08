import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/subscription/presentation/subscription.dart';

class ProfilePictureUploadPage extends StatefulWidget {
  const ProfilePictureUploadPage({Key? key}) : super(key: key);

  @override
  _ProfilePictureUploadPageState createState() =>
      _ProfilePictureUploadPageState();
}

class _ProfilePictureUploadPageState extends State<ProfilePictureUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Form(
          child: Column(
            children: [
              const AuthHeading(
                "Set Profile Picture",
                "Set your profile picture so people or future mentors can identify who you are.",
              ),
              Gap.lg,
              DottedBorder(
                radius: Corners.xsRadius,
                padding: EdgeInsets.zero,
                borderType: BorderType.RRect,
                dashPattern: const [5, 4],
                child: Container(
                  height: context.width - 120,
                  width: context.width - 120,
                  decoration: BoxDecoration(
                    color: AppColors.palette[100],
                    borderRadius: Corners.smBorder,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        'Browse Gallery',
                        height: 32,
                        width: 140,
                        onTap: () {},
                      ),
                      Gap.sm,
                      Text(
                        "jpg, jpeg, png - not more than 2mb",
                        style: context.textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
              const Gap(25),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Rachel Choo\n",
                      style: context.textTheme.caption!
                          .changeColor(AppColors.primary)
                          .size(16),
                    ),
                    const TextSpan(text: "Human Resources"),
                  ],
                ),
                textAlign: TextAlign.center,
                style: context.textTheme.caption,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "Skip",
                    style: context.textTheme.bodyLarge!
                        .changeColor(AppColors.primary),
                  ).onTap(() {
                    context.push(const SubscriptionPage());
                  }),
                  Gap.lg,
                  Expanded(
                    child: Button(
                      'Upload Profile Picture',
                      onTap: () {
                        context.push(const SubscriptionPage());
                      },
                    ),
                  ),
                ],
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
