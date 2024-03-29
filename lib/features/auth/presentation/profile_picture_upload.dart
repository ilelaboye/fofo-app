import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/subscription/presentation/subscription.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/notification.dart';
import '../../../service/auth_service/auth_provider.dart';

class ProfilePictureUploadPage extends StatefulWidget {
  const ProfilePictureUploadPage({Key? key, required this.user})
      : super(key: key);
  final Map user;
  @override
  _ProfilePictureUploadPageState createState() =>
      _ProfilePictureUploadPageState();
}

class _ProfilePictureUploadPageState extends State<ProfilePictureUploadPage> {
  File? image;
  bool loading = false;

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("log- ${widget.user.toString()}");
    return Scaffold(
      appBar: const Appbar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
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
              Container(),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "Skip",
                    style: context.textTheme.bodyLarge!
                        .changeColor(AppColors.primary),
                  ).onTap(() {
                    context.push(SubscriptionPage(user: widget.user));
                  }),
                  Gap.lg,
                  Expanded(
                    child: Button(
                      'Upload Profile Picture',
                      onTap: () async {
                        if (image == null) {
                          showNotification(
                              context, false, "Image field is required");
                          return;
                        }
                        if (widget.user['userId'] != null &&
                            widget.user['accessToken'] != null) {
                          print('before upl');
                          print(widget.user);
                          EasyLoading.show(status: "Loading...");
                          Map<String, dynamic>? response =
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .uploadToServer(
                                      context,
                                      image!,
                                      widget.user['userId']!,
                                      widget.user['accessToken']);
                          EasyLoading.dismiss();
                          print('tie');
                          print(loading);
                          print(response);
                          if (response!['status']) {
                            context.push(SubscriptionPage(user: widget.user));
                          } else {
                            showNotification(
                                context, false, response['message']);
                          }
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
