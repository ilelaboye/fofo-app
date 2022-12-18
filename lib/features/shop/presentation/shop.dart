import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/shop/presentation/product_card.dart';
import 'package:fofo_app/features/shop/presentation/product_desc.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/loader.dart';
import '../../../models/shop/products.dart';
import '../../../service/shop/shop.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late final Products products;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  getProducts() async {
    products = await Provider.of<ShopProvider>(context, listen: false)
        .getProducts(context);
    print('init prod returns');
    print(products);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Loader();
    } else {
      return Scaffold(
        appBar: const ShopAppbar(title: "Shop"),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Gap.lg,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      hintText: "Product name",
                      prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                    ),
                  ),
                  Gap.md,
                  const Icon(PhosphorIcons.funnel)
                ],
              ),
            ),
            Gap.lg,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: CategorySection(
                  title: "Shop by category",
                  categories: categoryItemsNoIcons(),
                  seeAll: true),
            ),
            Gap.lg,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader("Products", seeAll: false),
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
                          right: index == products.products!.length - 1
                              ? Insets.lg
                              : 0,
                        ),
                        child: ShopCard(product: products.products![index]))
                    .onTap(
                  () => context.push(
                      ProductDescriptionPage(id: products.products![index].id)),
                ),
                itemCount: products.products!.length,
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: Insets.lg),
            //   height: 100,
            //   decoration: BoxDecoration(
            //     color: AppColors.palette[100],
            //     borderRadius: Corners.smBorder,
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: SectionHeader(
                "Top sellers",
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
                    right:
                        index == products.products!.length - 1 ? Insets.lg : 0,
                  ),
                  child: ShopCard(product: products.products![index]).onTap(
                    () => context.push(const ProductDescriptionPage()),
                  ),
                ),
                itemCount: products.products!.length,
              ),
            ),
            const Gap(50)
          ],
        )),
      );
    }
  }
}
