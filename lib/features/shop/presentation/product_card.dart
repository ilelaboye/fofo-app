import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../models/shop/product.dart';

class ShopCard extends StatelessWidget {
  final Product? product;
  final double? imgHeight;
  const ShopCard({this.imgHeight, this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: NetworkImg(
              product!.product_images![0].secure_url.toString(),
              height: imgHeight,
            ),
          ),
          Gap.sm,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + product!.product_variation![0].price.toString(),
                // "\$100",
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
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              product!.name.toString(),
              style: context.textTheme.bodyMedium,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
