import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:fofo_app/models/user_model/user_model.dart';
import 'package:fofo_app/service/user_provider/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/auth_service/auth_provider.dart';

class ProfilePictureUploadPage extends StatefulWidget {
  const ProfilePictureUploadPage({Key? key}) : super(key: key);

  @override
  _ProfilePictureUploadPageState createState() =>
      _ProfilePictureUploadPageState();
}

class _ProfilePictureUploadPageState extends State<ProfilePictureUploadPage> {
  File? image;

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).authUser;
    print("log- ${user.toString()}");
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
              image != null
                  ? Container(
                      height: context.width - 120,
                      width: context.width - 120,
                      decoration: BoxDecoration(
                        color: AppColors.palette[100],
                        borderRadius: Corners.smBorder,
                      ),
                      child: Image.file(image!))
                  : DottedBorder(
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
                              onTap: () {
                                pickImage();
                              },
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
                      text: user?.fullname ?? "",
                      style: context.textTheme.caption!
                          .changeColor(AppColors.primary)
                          .size(16),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: context.textTheme.caption,
              ),
              Text(user?.field ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(103, 109, 126, 1))),
              Container(),
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
                        if (user?.userId != null && user?.accessToken != null) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .uploadToServer(
                                  image!, user!.userId!, user.accessToken!);
                          context.push(const SubscriptionPage());
                        }
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
