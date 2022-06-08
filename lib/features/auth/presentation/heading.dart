import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';

class AuthHeading extends StatelessWidget {
  final String title, subtitle;
  const AuthHeading(this.title, this.subtitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium.bold
              .size(24)
              .changeColor(AppColors.primary),
        ),
        Gap.sm,
        SizedBox(
          // width: context.width / 2,
          child: Text(
            subtitle,
            style: context.textTheme.bodyMedium
                .size(12)
                .changeColor(AppColors.palette[700]!)
                .copyWith(height: 1.8),
          ),
        ),
      ],
    );
  }
}
