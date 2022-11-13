import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';

import '../../features/blog/presentation/blog.dart';
import '../../models/feed/feed.dart';

class BlogCard extends StatelessWidget {
  final Feed feed;
  BlogCard({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(BlogPage(id: feed.id)),
      child: Container(
        width: 175,
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
            if (feed.blogImage != null)
              ClipRRect(
                child: NetworkImg(
                  feed.blogImage.toString(),
                  width: context.width,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            Gap.xs,
            Text(
              feed.blogCategory!.name.toString().titleCaseSingle(),
              style: context.textTheme.bodySmall
                  .changeColor(AppColors.palette[600]!),
            ),
            Gap.xs,
            Text(
              feed.name.length > 22
                  ? feed.name.toString().substring(0, 22).titleCaseSingle() +
                      '...'
                  : feed.name.toString().titleCaseSingle(),
              // maxLines: 2,
              style: context.textTheme.caption
                  .changeColor(AppColors.palette[600]!)
                  .bold
                  .copyWith(height: 1.4),
            )
          ],
        ),
      ),
    );
  }
}
