import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/notification.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout.dart';
import 'package:fofo_app/service/shop/shop.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class BagPage extends StatefulWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  late final List products;
  bool loaded = true;
  @override
  void initState() {
    super.initState();

    // products = Provider.of<ShopProvider>(context, listen: true).cart;
    // print(products);
    // getCart();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   getCart();
  // }

  // getCart() async {
  //   print('get cart');
  //   products = await Provider.of<ShopProvider>(context, listen: true).cart;
  //   print(products);
  //   setState(() {
  //     loaded = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ShopProvider>(context).cart;
    double sum = 0;
    products.forEach((element) {
      sum = sum +
          (element['quantity'] * element['product_variation'][0]['price']);
    });
    print('summung');
    print(sum);
    return Scaffold(
      appBar: const Appbar(
        title: "My Bag",
      ),
      bottomSheet: products.isNotEmpty
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: Insets.lg, vertical: 10),
              child: Button(
                "Proceed To Checkout",
                onTap: () => context.push(const ShopCheckoutPage()),
              ),
            )
          : const EmytyBag(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.md,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Text("${products.length} item(s) in cart"),
            ),
            Gap.md,
            Wrap(
                children: products
                    .map((product) => BagItem(
                          product: product,
                        ))
                    .toList()),
            Gap(20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Insets.md),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SUB TOTAL'),
                    Text(
                      '\$${sum}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                Gap(10),
                Divider(),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SHIPPING'),
                    Text(
                      'FREE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                Gap(10),
                Divider(),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL'),
                    Text(
                      '\$${sum}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}

class BagItem extends StatefulWidget {
  final Map product;
  const BagItem({required this.product, Key? key}) : super(key: key);

  @override
  State<BagItem> createState() => _BagItemState();
}

class _BagItemState extends State<BagItem> {
  @override
  Widget build(BuildContext context) {
    print('printint var');
    print(widget.product['variation']);
    print('printing quantity');
    print(widget.product['quantity']);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.lg, vertical: Insets.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: NetworkImg(
              widget.product['product_images'][0]['secure_url'],
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
                  "\$${widget.product['variation']['price'] * widget.product['quantity']}",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.primary)
                      .size(22)
                      .bold,
                ),
                Gap.sm,
                Text(
                  widget.product['name'],
                  style: context.textTheme.bodyMedium,
                ),
                Gap.md,
                Row(
                  children: [
                    // Row(
                    //   children: const [
                    //     Text("Black"),
                    //     Gap.xs,
                    //     Icon(
                    //       PhosphorIcons.caretDown,
                    //     ),
                    //   ],
                    // ),
                    // Gap.sm,
                    Row(
                      children: [
                        Text(
                            "Size: ${widget.product['variation']['size'].toString()}"),
                        Gap.xs,
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
                    ).onTap(() async {
                      Map resp = {};
                      if (widget.product['quantity'] > 1) {
                        setState(() {
                          widget.product['quantity'] -= 1;
                        });
                        resp = await Provider.of<ShopProvider>(context,
                                listen: false)
                            .addToCart(
                                widget.product,
                                widget.product['quantity'],
                                widget.product['color'],
                                widget.product['variation']);
                      } else {
                        resp = await Provider.of<ShopProvider>(context,
                                listen: false)
                            .reduceOrRemoveFromCart(widget.product);
                        setState(() {});
                      }

                      showNotification(context, true, resp['msg']);
                    }),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Insets.sm),
                      child: Text(
                        widget.product['quantity'].toString(),
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
                    ).onTap(() async {
                      setState(() {
                        widget.product['quantity'] += 1;
                      });
                      var resp = await Provider.of<ShopProvider>(context,
                              listen: false)
                          .addToCart(
                              widget.product,
                              widget.product['quantity'],
                              widget.product['color'],
                              widget.product['variation']);
                      showNotification(context, true, resp['msg']);
                      // print(widget.product);
                    }),
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
