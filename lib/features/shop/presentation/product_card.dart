import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShopCard extends StatelessWidget {
  final double? imgHeight;
  const ShopCard({this.imgHeight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: LocalImage(
              "shop".png,
              height: imgHeight,
            ),
          ),
          Gap.sm,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$100",
                style: context.textTheme.bodyMedium
                    .changeColor(AppColors.primary)
                    .size(18)
                    .bold,
              ),
              const Icon(
                PhosphorIcons.heart,
                size: 20,
              )
            ],
          ),
          Gap.sm,
          Text(
            "Plain black medium sized tote bag",
            style: context.textTheme.bodyMedium,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
