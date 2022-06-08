import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';

class ProductReviewsPage extends StatelessWidget {
  const ProductReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ShopAppbar(title: "Reviews"),
      body: Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: ReviewAllList(),
      ),
    );
  }
}
