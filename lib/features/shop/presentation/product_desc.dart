import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/shop/presentation/product_card.dart';
import 'package:fofo_app/features/shop/presentation/product_reviews.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProductDescriptionPage extends StatefulWidget {
  const ProductDescriptionPage({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  String imgUrl = 'shop2';
  String currentSize = "S";
  Color currentColor = Colors.black;
  @override
  Widget build(BuildContext context) {
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
                LocalImage(
                  imgUrl.png,
                  width: context.width,
                  height: 250,
                ),
                Gap.md,
                Row(
                  children: ["shop2", "shop", "shop"]
                      .map(
                        (img) => Padding(
                          padding: const EdgeInsets.only(
                            right: Insets.sm,
                          ),
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                borderRadius: Corners.xsBorder,
                                border: Border.all(
                                  color: imgUrl == img
                                      ? Colors.black
                                      : Colors.transparent,
                                )),
                            child: ClipRRect(
                              borderRadius: Corners.xsBorder,
                              child: LocalImage(
                                img.png,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ).onTap(() {
                            setState(() {
                              imgUrl = img;
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
                    "Plain black medium sized Tote bag",
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
                          index != 4
                              ? PhosphorIcons.starFill
                              : PhosphorIcons.star,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Gap.xs,
                    const Text("(4)"),
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
                    Text(
                      "\$100.00",
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
                  "There are many variations of passages of Lorem Ipsum dole available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to often repeat predefined chunks as necessary, making this the first",
                  style:
                      context.textTheme.caption.size(12).copyWith(height: 1.8),
                ),
                Gap.lg,
                const SectionHeader("Select size"),
                Gap.sm,
                Wrap(
                  spacing: Insets.md,
                  runSpacing: Insets.sm,
                  children: ["S", "M", "L", "XL", "XXL"]
                      .map(
                        (size) => Container(
                          decoration: BoxDecoration(
                            borderRadius: Corners.xsBorder,
                            color: currentSize == size
                                ? AppColors.primary
                                : AppColors.palette[200],
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: Insets.sm,
                            horizontal: Insets.md,
                          ),
                          child: Text(
                            size,
                            style: context.textTheme.bodyMedium
                                .size(14)
                                .changeColor(
                                  currentSize == size
                                      ? Colors.white
                                      : AppColors.primary,
                                ),
                          ),
                        ).onTap(() {
                          setState(() {
                            currentSize = size;
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
                  children: [
                    Colors.black,
                    Colors.red,
                    Colors.blue,
                    Colors.yellow,
                    Colors.pink,
                  ]
                      .map(
                        (color) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                          height: 36,
                          width: 36,
                          child: currentColor == color
                              ? const Icon(
                                  PhosphorIcons.checkCircleFill,
                                  color: Colors.white,
                                )
                              : null,
                        ).onTap(() {
                          setState(() {
                            currentColor = color;
                          });
                        }),
                      )
                      .toList(),
                ),
                Gap.lg,
                Button(
                  "Add This To Bag",
                  onTap: () {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
            child: SectionHeader(
              "Reviews",
              seeAll: true,
              onClickSeeAll: () {
                context.push(const ProductReviewsPage());
              },
            ),
          ),
          Gap.md,
          const ReviewList(),
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
