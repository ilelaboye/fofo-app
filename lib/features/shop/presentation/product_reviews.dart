import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/features/shop/presentation/order.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/button.dart';
import '../../../core/widgets/gap.dart';
import '../../../service/shop/shop.dart';
import './addReview.dart';

class ProductReviewsPage extends StatefulWidget {
  List reviews = [];
  String productId;
  ProductReviewsPage({Key? key, required this.reviews, required this.productId})
      : super(key: key);

  @override
  State<ProductReviewsPage> createState() => _ProductReviewsPageState();
}

class _ProductReviewsPageState extends State<ProductReviewsPage> {
  bool canWriteReview = false;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    getCanUserReview();
  }

  getCanUserReview() async {
    print('start user g review');
    EasyLoading.show(status: "Loading...");
    Map response = await Provider.of<ShopProvider>(context, listen: false)
        .canUserReview(context, widget.productId.toString());
    print('get user can review');
    print(response);
    EasyLoading.dismiss();
    setState(() {
      canWriteReview = response['canUserReviewThisProduct'];

      // currentSize = product['product']['product_variation'][0]['size'];
      // currentPrice = product['product']['product_variation'][0]['price'];
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
            appBar: const ShopAppbar(title: "Reviews"),
            bottomSheet: canWriteReview
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.md,
                      vertical: Insets.md,
                    ),
                    color: AppColors.scaffold,
                    // height: 90,
                    width: context.width,
                    child: Button(
                      "Add A Review",
                      onTap: () async {
                        context.push(AddProductReview(
                            productId: widget.productId,
                            reviews: widget.reviews));
                      },
                    ),
                  )
                : const SizedBox(
                    height: 1,
                  ),
            body: Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const Divider(height: Insets.lg),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index2) => Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Icon(
                                    index2 < widget.reviews[index]['rating']
                                        ? PhosphorIcons.starFill
                                        : PhosphorIcons.star,
                                    size: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            Gap.sm,
                            Text(
                              widget.reviews[index]['name'],
                              style: context.textTheme.bodyMedium
                                  .size(15)
                                  .changeColor(AppColors.primary),
                            )
                          ],
                        ),
                        Text(
                          widget.reviews[index]['createdAt']
                              .toString()
                              .getDateDifference(),
                          style: context.textTheme.caption
                              .changeColor(AppColors.palette[600]!),
                        )
                      ],
                    ),
                    Gap.md,
                    Text(
                      widget.reviews[index]['comment'],
                      style: context.textTheme.caption
                          .changeColor(AppColors.palette[700]!)
                          .size(13)
                          .copyWith(height: 1.4),
                    )
                  ],
                ),
                itemCount: widget.reviews.length,
              ),
            ),
          )
        : Container();
  }
}
