import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Orders"),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(
          imgUrl: index == 0 ? "shop".png : "shop2".png,
          status: index == 0 ? "Pending" : "Delivered",
        ),
        itemCount: 2,
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imgUrl;
  final String status;

  const OrderItem({required this.imgUrl, this.status = "Pending", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color =
        status == "Pending" ? const Color(0xffE99F0C) : const Color(0xff3B9B7B);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.lg, vertical: Insets.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: LocalImage(
              imgUrl,
              height: 110,
              width: 100,
            ),
          ),
          Gap.sm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "\$100.00",
                      style: context.textTheme.bodyMedium
                          .changeColor(AppColors.primary)
                          .size(22)
                          .bold,
                    ),
                    Gap.sm,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Insets.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: Corners.smBorder,
                        border: Border.all(color: color),
                        color: status == "Pending"
                            ? const Color(0xffFFF9F0)
                            : const Color(0xffF3FBF9),
                      ),
                      child: Text(
                        status,
                        style: context.textTheme.caption.changeColor(color),
                      ),
                    ),
                  ],
                ),
                Gap.sm,
                Text(
                  "Plain black medium sized tote bag",
                  style: context.textTheme.bodyMedium.size(17),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
