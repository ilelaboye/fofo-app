import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/shop/presentation/product_card.dart';
import 'package:fofo_app/features/shop/presentation/product_desc.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ShopAppbar(title: "Swags"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Showing all swags (10)"),
            Gap.md,
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.55,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) => const ShopCard(
                imgHeight: 180,
              ).onTap(
                () => context.push(const ProductDescriptionPage()),
              ),
              itemCount: 10,
            )
          ],
        ),
      )),
    );
  }
}
