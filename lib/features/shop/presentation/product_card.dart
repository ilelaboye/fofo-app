import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../models/shop/product.dart';

class ShopCard extends StatelessWidget {
  final Map? product;
  final double? imgHeight;
  const ShopCard({this.imgHeight, this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.03)),
        color: Colors.grey.withOpacity(0.1),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 3,
        //     blurRadius: 4,
        //     // offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: NetworkImg(
              product!['product_images'][0]['secure_url'].toString(),
              height: 65,
            ),
          ),
          Gap.sm,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + product!['product_variation'][0]['price'].toString(),
                // "\$100",
                style: context.textTheme.bodyMedium
                    .changeColor(AppColors.primary)
                    .size(15)
                    .bold,
              ),
            ],
          ),
          // Gap.sm,
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              product!['name'].toString(),
              style: context.textTheme.bodyMedium.size(12),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
