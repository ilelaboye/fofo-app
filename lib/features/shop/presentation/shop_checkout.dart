import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout_addshipping.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout_delivery.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShopCheckoutPage extends StatelessWidget {
  const ShopCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Checkout"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap.lg,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: AuthHeading("Shipping address",
                "Communities are groups of people that connect for work, projects, or common interests."),
          ),
          Gap.lg,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
            child: TextInputField(
              labelText: "Select country",
              hintText: "United States of America",
              prefix: Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.fromLTRB(
                  Insets.md,
                  Insets.sm,
                  Insets.sm,
                  Insets.sm,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.error,
                ),
              ),
              suffixIcon: Icon(
                PhosphorIcons.caretDown,
                color: AppColors.primary,
              ),
            ),
          ),
          Gap.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
            child: Row(
              children: [
                const Icon(
                  PhosphorIcons.info,
                  size: 17,
                ),
                Gap.sm,
                Expanded(
                  child: Text(
                    "Delivery is limited to few selected countries for now.",
                    style: context.textTheme.caption,
                  ),
                )
              ],
            ),
          ),
          Gap.lg,
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.sm, left: Insets.lg),
            child: Text(
              "Shipping address",
              style: context.textTheme.bodyMedium!
                  .size(16)
                  .changeColor(AppColors.palette[900]!),
            ),
          ),
          Gap.sm,
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Insets.lg),
                  child: GestureDetector(
                    onTap: () => context.push(const AddshippingAddressPage()),
                    child: SizedBox(
                      width: 40,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Insets.xs),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              PhosphorIcons.plus,
                              color: Colors.white,
                            ),
                          ),
                          Gap.xs,
                          const Text("Add")
                        ],
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.md : Insets.sm,
                      right: index == 2 ? Insets.md : 0,
                    ),
                    child: const AddressCard(),
                  ),
                ),
              ],
            ),
          ),
          Gap.lg,
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
            child: Button(
              "Deliver To This Address",
              onTap: () => context.push(const CheckoutDeliveryPage()),
            ),
          ),
          const Gap(50)
        ],
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.palette[100],
        borderRadius: Corners.smBorder,
      ),
      padding: const EdgeInsets.symmetric(
          vertical: Insets.sm, horizontal: Insets.sm),
      child: Row(
        children: [
          Radio(
            value: true,
            groupValue: true,
            onChanged: (value) {},
            activeColor: AppColors.primary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address",
                style: context.textTheme.bodyMedium.bold,
              ),
              Gap.xs,
              const Text(
                "8 Oxford street",
                maxLines: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
