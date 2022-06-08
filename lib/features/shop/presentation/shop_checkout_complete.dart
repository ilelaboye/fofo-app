import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/shop/presentation/order.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CheckoutCompletePage extends StatelessWidget {
  const CheckoutCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Checkout"),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(PhosphorIcons.shoppingBagThin, size: 100),
            Gap.sm,
            Text(
              "Thank you for your order",
              style: context.textTheme.headlineSmall.bold
                  .changeColor(AppColors.primary),
              textAlign: TextAlign.center,
            ),
            Gap.sm,
            Text(
              "Please check your email inbox for your order confirmation.",
              textAlign: TextAlign.center,
              style: context.textTheme.caption
                  .changeColor(AppColors.palette[600])
                  .copyWith(height: 1.4),
            ),
            Gap.lg,
            Button(
              "Continue Shopping",
              onTap: () => context.push(const OrderPage()),
            )
          ],
        ),
      ),
    );
  }
}
