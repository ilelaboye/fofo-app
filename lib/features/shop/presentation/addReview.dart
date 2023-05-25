import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/features/shop/presentation/product_reviews.dart';
import 'package:fofo_app/service/auth_service/auth_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/notification.dart';
import '../../../core/widgets/text_input.dart';
import '../../../service/shop/shop.dart';

class AddProductReview extends StatefulWidget {
  final String productId;
  final List reviews;
  const AddProductReview(
      {required this.productId, required this.reviews, Key? key})
      : super(key: key);

  @override
  State<AddProductReview> createState() => _AddProductReviewState();
}

class _AddProductReviewState extends State<AddProductReview> {
  int rating = 0;
  String comment = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(DateTime.now());
  }

  postReview(comment) async {
    print('review');
    EasyLoading.show(status: 'loadings...');
    Map response = await Provider.of<ShopProvider>(context, listen: false)
        .postReview(context, widget.productId, rating, comment);
    setState(() {
      widget.reviews.add({
        "rating": rating,
        "comment": comment,
        "name": Provider.of<AuthProvider>(context, listen: false)
            .userProfile
            ?.fullname,
        "createdAt": DateTime.now()
      });
    });

    print('rwii');
    print(widget.reviews);
    _controller.clear();
    EasyLoading.dismiss();
    showNotification(context, true, "Review added successfully");
    context.push(ProductReviewsPage(
        reviews: widget.reviews, productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(Insets.md),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How was the product?',
                  style: TextStyle(fontSize: 25, color: AppColors.palette),
                ),
                const Text(
                  'Add a review and rate this product',
                  style: TextStyle(fontSize: 14),
                ),
                Gap.lg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      rating > 0 ? PhosphorIcons.starFill : PhosphorIcons.star,
                      size: 39,
                    ).onTap(() {
                      setState(() {
                        rating = 1;
                      });
                    }),
                    Icon(
                      rating > 1 ? PhosphorIcons.starFill : PhosphorIcons.star,
                      size: 39,
                    ).onTap(() {
                      setState(() {
                        rating = 2;
                      });
                    }),
                    Icon(
                      rating > 2 ? PhosphorIcons.starFill : PhosphorIcons.star,
                      size: 39,
                    ).onTap(() {
                      setState(() {
                        rating = 3;
                      });
                    }),
                    Icon(
                      rating > 3 ? PhosphorIcons.starFill : PhosphorIcons.star,
                      size: 39,
                    ).onTap(() {
                      setState(() {
                        rating = 4;
                      });
                    }),
                    Icon(
                      rating > 4 ? PhosphorIcons.starFill : PhosphorIcons.star,
                      size: 39,
                    ).onTap(() {
                      setState(() {
                        rating = 5;
                      });
                    }),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                children: [
                  Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: AppColors.primary))),
                        child: TextInputField(
                          enabled: true,
                          controller: _controller,
                          hintText: "Type in your comment",
                          validator: (value) =>
                              value!.isEmpty ? "Please enter review" : null,
                          onSaved: (value) => comment = value!,
                        ),
                      )),
                  Button(
                    "Add A Review",
                    onTap: () async {
                      final form = formKey.currentState!;
                      print('hello world');

                      form.save();
                      print(rating);
                      print(comment);
                      if (comment.isEmpty) {
                        showNotification(
                            context, false, "Comment field required");
                      } else {
                        postReview(comment);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
