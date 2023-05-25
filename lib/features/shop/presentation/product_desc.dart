import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/notification.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/shop/presentation/product_card.dart';
import 'package:fofo_app/features/shop/presentation/product_reviews.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';
import 'package:fofo_app/models/shop/getProductById.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/loader.dart';
import '../../../service/shop/shop.dart';

class ProductDescriptionPage extends StatefulWidget {
  final String? id;
  const ProductDescriptionPage({this.id, Key? key}) : super(key: key);

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  late final Map product;

  late final String imgUrl;
  late final String currentSize;
  late final String currentPrice;
  late final Map currentVariation;
  late Color currentColor;
  int quantity = 1;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // print('inti pro');
    // print(DateTime.now().toString().getDateDifference());
    getProduct();
  }

  getProduct() async {
    print('start single prod');
    product = await Provider.of<ShopProvider>(context, listen: false)
        .getProduct(context, widget.id.toString());
    print('get single prod returns');
    print(product);
    setState(() {
      EasyLoading.dismiss();
      imgUrl = product['product']['product_images'][0]['secure_url'];
      currentVariation = product['product']['product_variation'][0];
      currentColor =
          (AppColors.colorMap()[currentVariation['color'].toLowerCase()] != null
              ? AppColors.colorMap()[currentVariation['color'].toLowerCase()]!
              : AppColors.colorMap()["white"])!;
      // currentSize = product['product']['product_variation'][0]['size'];
      // currentPrice = product['product']['product_variation'][0]['price'];
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Loader();
    } else {
      return Scaffold(
        appBar: const ShopAppbar(title: "Product"),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NetworkImg(
                    imgUrl.toString(),
                    width: context.width,
                    height: 250,
                  ),
                  Gap.md,
                  Row(
                    children: product['product']['product_images']
                        .map<Widget>(
                          (img) => Padding(
                            padding: const EdgeInsets.only(
                              right: Insets.sm,
                            ),
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                  borderRadius: Corners.xsBorder,
                                  border: Border.all(
                                    color: imgUrl == img['secure_url']
                                        ? Colors.black
                                        : Colors.transparent,
                                  )),
                              child: ClipRRect(
                                borderRadius: Corners.xsBorder,
                                child: NetworkImg(
                                  img['secure_url'],
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ).onTap(() {
                              setState(() {
                                imgUrl = img['secure_url'];
                              });
                            }),
                          ),
                        )
                        .toList(),
                  ),
                  Gap.md,
                  SizedBox(
                    width: context.width / 1.2,
                    child: Text(
                      product['product']['name'],
                      style: context.textTheme.headlineMedium
                          .size(20)
                          .changeColor(AppColors.primary),
                    ),
                  ),
                  Gap.sm,
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            index < product['product']['ratings']
                                ? PhosphorIcons.starFill
                                : PhosphorIcons.star,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Gap.xs,
                      Text('(${product['product']['ratings']})'),
                    ],
                  ),
                  Gap.md,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          ).onTap(() {
                            setState(() {
                              if (quantity > 1) {
                                quantity -= 1;
                              }
                            });
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Insets.sm),
                            child: Text(
                              quantity.toString(),
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
                          ).onTap(() {
                            setState(() {
                              quantity += 1;
                            });
                          }),
                        ],
                      ),
                      Text(
                        "\$" + currentVariation['price'].toString(),
                        style: context.textTheme.bodyMedium
                            .changeColor(AppColors.primary)
                            .size(22)
                            .bold,
                      )
                    ],
                  ),
                  Gap.lg,
                  const SectionHeader("About"),
                  Gap.sm,
                  Text(
                    product['product']['description'].toString(),
                    style: context.textTheme.caption
                        .size(12)
                        .copyWith(height: 1.8),
                  ),
                  Gap.lg,
                  const SectionHeader("Select size"),
                  Gap.sm,
                  Wrap(
                    spacing: Insets.md,
                    runSpacing: Insets.sm,
                    children: product['product']['product_variation']
                        .map<Widget>(
                          (item) => Container(
                            decoration: BoxDecoration(
                              borderRadius: Corners.xsBorder,
                              color: currentVariation['size'] == item['size']
                                  ? AppColors.primary
                                  : AppColors.palette[200],
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: Insets.sm,
                              horizontal: Insets.md,
                            ),
                            child: Text(
                              item['size'],
                              style: context.textTheme.bodyMedium
                                  .size(14)
                                  .changeColor(
                                    currentVariation['size'] == item['size']
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                            ),
                          ).onTap(() {
                            setState(() {
                              currentVariation = item;
                            });
                          }),
                        )
                        .toList(),
                  ),
                  Gap.lg,
                  const SectionHeader("Color"),
                  Gap.sm,
                  Wrap(
                    spacing: Insets.md,
                    runSpacing: Insets.sm,
                    children: product['product']['product_variation']
                        .map<Widget>(
                          (color) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorMap()[
                                  color['color'].toLowerCase()],
                            ),
                            height: 36,
                            width: 36,
                            child: currentColor ==
                                    AppColors.colorMap()[
                                        color['color'].toLowerCase()]
                                ? const Icon(
                                    PhosphorIcons.checkCircleFill,
                                    color: Colors.white,
                                  )
                                : null,
                          ).onTap(() {
                            setState(() {
                              currentColor = AppColors.colorMap()[
                                  color['color'].toLowerCase()]!;
                            });
                          }),
                        )
                        .toList(),
                  ),
                  Gap.lg,
                  Button(
                    "Add This To Bag",
                    onTap: () async {
                      print('adding to c');
                      // print(product['product']);
                      Map cartResp = await Provider.of<ShopProvider>(context,
                              listen: false)
                          .addToCart(product['product'], quantity, currentColor,
                              currentVariation);
                      showNotification(context, true, cartResp['msg']);
                      print(cartResp);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader(
                "Reviews",
                seeAll: product['reviews']['docs'].length > 0 ? true : false,
                onClickSeeAll: () {
                  context.push(ProductReviewsPage(
                      reviews: product['reviews']['docs'],
                      productId: product['product']['id']));
                },
              ),
            ),
            Gap.md,
            ReviewList(
              reviews: product['reviews']['docs'],
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader(
                "You might like",
                seeAll: true,
              ),
            ),
            Gap.md,
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Insets.lg : Insets.sm,
                    right: index ==
                            product['product_you_may_like']['docs'].length - 1
                        ? Insets.lg
                        : 0,
                  ),
                  child: ShopCard(
                          product: product['product_you_may_like']['docs']
                              [index],
                          imgHeight: 10)
                      .onTap(
                    () => context.push(ProductDescriptionPage(
                        id: product['product_you_may_like']['docs'][index]
                            ['id'])),
                  ),
                ),
                itemCount: product['product_you_may_like']['docs'].length,
              ),
            ),
            const Gap(50)
          ],
        )),
      );
    }
  }
}
