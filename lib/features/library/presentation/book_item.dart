import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BookItem extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String? author;
  const BookItem(this.imgUrl, this.name, this.author, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: LocalImage(
              imgUrl,
              height: 80,
              width: 60,
            ),
          ),
          Gap.sm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                      ),
                    ),
                    Gap.sm,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Insets.md, vertical: Insets.sm),
                      decoration: BoxDecoration(
                        color: AppColors.palette[100],
                        borderRadius: Corners.lgBorder,
                      ),
                      child: const Text("\$9.99"),
                    )
                  ],
                ),
                Gap.sm,
                Text(author.toString(), style: context.textTheme.caption),
                Gap.sm,
                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Icon(
                        index != 4
                            ? PhosphorIcons.starFill
                            : PhosphorIcons.star,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  )..addAll([
                      Gap.sm,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Insets.sm,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          border: Border.all(
                            color: const Color(0xff3B9B7B),
                            width: 0.5,
                          ),
                          color: const Color(0xffF3FBF9),
                        ),
                        child: Text(
                          "AMAZON",
                          style: context.textTheme.caption
                              .changeColor(const Color(0xff3B9B7B)),
                        ),
                      )
                    ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
