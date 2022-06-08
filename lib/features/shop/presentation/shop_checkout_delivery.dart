import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout_payment.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CheckoutDeliveryPage extends StatelessWidget {
  const CheckoutDeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Checkout"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.lg,
            const AuthHeading("Delivery",
                "Communities are groups of people that connect for work, projects, or common interests."),
            Gap.lg,
            const DeliveryOptionItem(
              "Standard delivery",
              "Delivered between Monday 25 January 2022 and Friday 30 January 2022.",
              notes:
                  "No delivery  on public holidays, all orders are subject to customs and duty charges.. more",
            ),
            const Divider(height: Insets.lg),
            const DeliveryOptionItem(
              "Express delivery",
              "Delivered between Monday 3 January 2022 and Friday 6 January 2022.",
              price: 45,
            ),
            const Spacer(),
            Button(
              "Proceed To Payment",
              onTap: () => context.push(const CheckoutPaymentPage()),
            ),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}

class DeliveryOptionItem extends StatelessWidget {
  final int price;
  final String title, subtitle;
  final String? notes;
  const DeliveryOptionItem(this.title, this.subtitle,
      {this.price = 0, this.notes, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio(
          value: price == 0 ? true : false,
          groupValue: true,
          onChanged: (value) {},
          activeColor: AppColors.primary,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: price == 0 ? "FREE - " : "\$$price - ",
                      style: context.textTheme.bodyMedium
                          .size(17)
                          .changeColor(AppColors.primary)),
                  TextSpan(text: title),
                ]),
                style: context.textTheme.caption.size(16),
              ),
              Gap.sm,
              Text(
                subtitle,
                style: context.textTheme.caption.size(13),
              ),
              Gap.sm,
              if (notes != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      PhosphorIcons.info,
                      size: 16,
                    ),
                    Gap.sm,
                    Expanded(
                      child: Text(
                        notes!,
                        style: context.textTheme.caption.size(12),
                      ),
                    ),
                  ],
                )
            ],
          ),
        )
      ],
    );
  }
}
