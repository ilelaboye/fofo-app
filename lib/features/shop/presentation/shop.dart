import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
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

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: SectionHeader("Today's deal", seeAll: true),
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
                        right: index == 2 ? Insets.lg : 0,
                      ),
                      child: const ShopCard())
                  .onTap(
                () => context.push(const ProductDescriptionPage()),
              ),
              itemCount: 3,
            ),
          ),
          Gap.lg,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Insets.lg),
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.palette[100],
              borderRadius: Corners.smBorder,
            ),
          ),
          Gap.lg,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: SectionHeader("Top sellers", seeAll: true),
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
                  right: index == 2 ? Insets.lg : 0,
                ),
                child: const ShopCard().onTap(
                  () => context.push(const ProductDescriptionPage()),
                ),
              ),
              itemCount: 3,
            ),
          ),
          const Gap(50)
        ],
      )),
    );
  }
}
