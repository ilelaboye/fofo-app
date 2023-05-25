import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/shop/presentation/product_card.dart';
import 'package:fofo_app/features/shop/presentation/product_desc.dart';
import 'package:fofo_app/features/shop/presentation/shop_appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loader.dart';
import '../../../models/shop/products.dart';
import '../../../service/shop/shop.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Map products = {};

  bool isLoaded = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCart();
    getProducts();
  }

  getProducts({String? search, String? nextPage}) async {
    products = await Provider.of<ShopProvider>(context, listen: false)
        .getProducts(context, search: search, nextPage: nextPage);
    print('init prod returns');
    print(products);

    setState(() {
      isLoaded = true;
      EasyLoading.dismiss();
    });
  }

  getCart() async {
    await Provider.of<ShopProvider>(context, listen: false).getCart();
  }

  @override
  Widget build(BuildContext context) {
    String search = '';
    final _formKey = GlobalKey<FormState>();
    if (!isLoaded) {
      return const Loader();
    } else {
      return Scaffold(
        appBar: const ShopAppbar(title: "Shop"),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              // Gap.lg,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputField(
                          hintText: "Product name",
                          prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                          onSaved: (value) => search = value!,
                        ),
                      ),
                      Gap.md,
                      const Icon(PhosphorIcons.magnifyingGlass).onTap(() async {
                        final form = _formKey.currentState!;
                        form.save();
                        setState(() {
                          isLoaded = false;
                        });
                        await getProducts(search: search);
                      })
                    ],
                  ),
                ),
              ),
              // Gap.lg,
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: Insets.md),
              //   child: CategorySection(
              //       title: "Shop by category",
              //       categories: categoryItemsNoIcons(),
              //       seeAll: true),
              // ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.md),
                child: SectionHeader(
                  "Top sellers",
                ),
              ),
              Gap.md,
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.md : Insets.sm,
                      right: index == products['products']['docs'].length - 1
                          ? Insets.md
                          : 0,
                    ),
                    child: ShopCard(
                            product: products['products']['docs'][index],
                            imgHeight: 10)
                        .onTap(
                      () => context.push(ProductDescriptionPage(
                          id: products['products']['docs'][index]['id'])),
                    ),
                  ),
                  itemCount: products['products']['docs'].length,
                ),
              ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.md),
                child: SectionHeader("Products", seeAll: false),
              ),
              Gap.md,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                child: SizedBox(
                  height: 800,
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: products['products']['docs'].length,
                    itemBuilder: (context, index) => productTile(
                            product: products['products']['docs'][index])
                        .onTap(() => context.push(ProductDescriptionPage(
                            id: products['products']['docs'][index]['id']))),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 10),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 150,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     physics: const BouncingScrollPhysics(),
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) => Padding(
              //             padding: EdgeInsets.only(
              //               left: index == 0 ? Insets.md : Insets.sm,
              //               right:
              //                   index == products['products']['docs'].length - 1
              //                       ? Insets.md
              //                       : 0,
              //             ),
              //             child: ShopCard(
              //                 product: products['products']['docs'][index]))
              //         .onTap(
              //       () => context.push(ProductDescriptionPage(
              //           id: products['products']['docs'][index]['id'])),
              //     ),
              //     itemCount: products['products']['docs'].length,
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  products['products']['hasPrevPage']
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Insets.md, vertical: 10),
                          child: Button(
                            "Prev",
                            width: 100,
                            height: 40,
                            color: AppColors.grey,
                            onTap: () async => {
                              EasyLoading.show(status: "Loading"),
                              await getProducts(
                                  nextPage: products['products']['nextPage']
                                      .toString()),
                              EasyLoading.dismiss(),
                              scrollController.animateTo(
                                  //go to top of scroll
                                  0, //scroll offset to go
                                  duration: Duration(
                                      milliseconds: 500), //duration of scroll
                                  curve: Curves.fastOutSlowIn //scroll type
                                  )
                            },
                          ),
                        )
                      : Container(),
                  products['products']['hasNextPage']
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Insets.md, vertical: 10),
                          child: Button(
                            "Next",
                            width: 100,
                            height: 40,
                            onTap: () async => {
                              EasyLoading.show(status: "Loading"),
                              await getProducts(
                                  nextPage: products['products']['nextPage']
                                      .toString()),
                              EasyLoading.dismiss(),
                              scrollController.animateTo(
                                  //go to top of scroll
                                  0, //scroll offset to go
                                  duration: Duration(
                                      milliseconds: 500), //duration of scroll
                                  curve: Curves.fastOutSlowIn //scroll type
                                  )
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: Insets.md),
              //   height: 100,
              //   decoration: BoxDecoration(
              //     color: AppColors.palette[100],
              //     borderRadius: Corners.smBorder,
              //   ),
              // ),

              Gap.md,
            ],
          ),
        ),
      );
    }
  }

  Widget productTile({product}) {
    return Container(
      // height: 1000,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.03)),
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: Corners.xsBorder,
            child: NetworkImg(
              product!['product_images'][0]['secure_url'].toString(),
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Gap.sm,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + product!['product_variation'][0]['price'].toString(),
                // "\$100",
                style: context.textTheme.bodyMedium
                    .changeColor(AppColors.primary)
                    .size(18)
                    .bold,
              ),
            ],
          ),
          Gap.sm,
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              product!['name'].toString(),
              style: context.textTheme.bodyMedium,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
