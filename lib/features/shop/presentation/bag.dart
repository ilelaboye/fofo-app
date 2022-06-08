import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BagPage extends StatelessWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "My Bag",
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(Insets.lg),
        child: Button(
          "Proceed To Checkout",
          onTap: () => context.push(const ShopCheckoutPage()),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap.md,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: Text("2 items : Total(excluding delivery) \$200.00"),
          ),
          Gap.md,
          BagItem(
            imgUrl: "shop".png,
          ),
          BagItem(
            imgUrl: "shop2".png,
          ),
        ],
      )),
    );
  }
}

class BagItem extends StatelessWidget {
  final String imgUrl;
  const BagItem({required this.imgUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              height: 170,
              width: 120,
            ),
          ),
          Gap.sm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$100.00",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.primary)
                      .size(22)
                      .bold,
                ),
                Gap.sm,
                Text(
                  "Plain black medium sized tote bag",
                  style: context.textTheme.bodyMedium,
                ),
                Gap.md,
                Row(
                  children: [
                    Row(
                      children: const [
                        Text("Black"),
                        Gap.xs,
                        Icon(
                          PhosphorIcons.caretDown,
                        ),
                      ],
                    ),
                    Gap.sm,
                    Row(
                      children: const [
                        Text("Small"),
                        Gap.xs,
                        Icon(
                          PhosphorIcons.caretDown,
                        ),
                      ],
                    )
                  ],
                ),
                Gap.sm,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Insets.xs),
                      decoration: BoxDecoration(
                        color: AppColors.palette[300],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        PhosphorIcons.minus,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Insets.sm),
                      child: Text(
                        "1",
                        style: context.textTheme.bodyMedium
                            .changeColor(AppColors.primary)
                            .size(20)
                            .bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(Insets.xs),
                      decoration: BoxDecoration(
                        color: AppColors.palette[300],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        PhosphorIcons.plus,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EmytyBag extends StatelessWidget {
  const EmytyBag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(PhosphorIcons.shoppingBagThin, size: 100),
          Gap.sm,
          Text(
            "Your bag is empty",
            style: context.textTheme.headlineSmall.bold
                .changeColor(AppColors.primary),
            textAlign: TextAlign.center,
          ),
          Gap.sm,
          Text(
            "Items remain in your bag for 24hours, and then they are completely removed from your bag.",
            textAlign: TextAlign.center,
            style: context.textTheme.caption
                .changeColor(AppColors.palette[600])
                .copyWith(height: 1.4),
          ),
          Gap.lg,
          Button(
            "Continue Shopping",
            onTap: () => context.pop(),
          )
        ],
      ),
    );
  }
}
