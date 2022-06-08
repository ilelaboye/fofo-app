import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(Insets.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: AppColors.palette[200]!,
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: LocalImage(
              "blog".png,
              width: context.width,
            ),
          ),
          Gap.xs,
          Text(
            "Career",
            style: context.textTheme.bodySmall
                .changeColor(AppColors.palette[600]!),
          ),
          Gap.xs,
          Text(
            "Progressing in career as a black woman",
            maxLines: 2,
            style: context.textTheme.caption
                .changeColor(AppColors.palette[600]!)
                .bold
                .copyWith(height: 1.4),
          )
        ],
      ),
    );
  }
}
