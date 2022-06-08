import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Create Post"
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                AppColors.error,
                radius: 20,
              ),
              Gap.sm,
              Expanded(
                child: TextFormField(
                  maxLines: 10,
                  minLines: 1,
                  style: context.textTheme.bodyText1,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind ?",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Gap.sm,
              const Padding(
                padding: EdgeInsets.only(top: Insets.sm),
                child: Icon(PhosphorIcons.paperPlaneTiltFill),
              )
            ],
          ),
        ),
      ),
    );
  }
}
