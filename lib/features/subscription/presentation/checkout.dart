import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Form(
              child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment",
                    style: context.textTheme.headlineMedium!.bold
                        .size(24)
                        .changeColor(AppColors.primary),
                  ),
                  Gap.sm,
                  Text(
                    "Communities are groups of people that connect for work, projects, or common interests.",
                    style: context.textTheme.bodyMedium
                        .size(12)
                        .changeColor(AppColors.palette[700]!)
                        .copyWith(height: 1.8),
                  ),
                ],
              ),
              Gap.lg,
              TextInputField(
                labelText: "Card Number",
                hintText: "4444 4444 4444 4444",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Name on Card",
                hintText: "E.g Susan Ray",
              ),
              const Gap(25),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextInputField(
                      labelText: "Expiration Date",
                      hintText: "E.g 10/22",
                    ),
                  ),
                  Gap.sm,
                  Expanded(
                    child: TextInputField(
                      labelText: "CVC",
                      hintText: "E.g 247",
                    ),
                  )
                ],
              ),
              const Gap(25),
              Container(
                width: context.width,
                padding: const EdgeInsets.all(Insets.md),
                decoration: BoxDecoration(
                  color: AppColors.palette[100],
                  borderRadius: Corners.smBorder,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Bag",
                      style: context.textTheme.bodyLarge
                          .changeColor(AppColors.primary)
                          .size(20)
                          .bold,
                    ),
                    Gap.md,
                    const Item("SUBTOTAL", "\$250.00"),
                    Item(
                      "Membership",
                      "",
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gold",
                            style: context.textTheme.bodyLarge
                                .changeColor(AppColors.primary)
                                .size(17),
                          ),
                          Gap.sm,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Change Plan"),
                              Gap.sm,
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.5),
                                child: Icon(
                                  PhosphorIcons.arrowRight,
                                  size: 18,
                                ),
                              )
                            ],
                          ).onTap(() => context.pop()),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Item("ORDER TOTAL", "\$250.00"),
                  ],
                ),
              ),
              const Gap(25),
              Container(
                padding: const EdgeInsets.all(Insets.md),
                decoration: const BoxDecoration(
                  color: Color(0xffF3FBF9),
                  borderRadius: Corners.smBorder,
                ),
                child: Row(
                  children: [
                    const Icon(
                      PhosphorIcons.shieldCheckFill,
                      color: Color(0xff3B9B7B),
                    ),
                    Gap.sm,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "100% cashback guarantee",
                            style: context.textTheme.caption
                                .changeColor(const Color(0xff3B9B7B))
                                .bold,
                          ),
                          Gap.sm,
                          Text(
                            "We promise you 100% cashback guarantee T&C applies.",
                            style: context.textTheme.caption
                                .changeColor(const Color(0xff195742)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Gap.lg,
              Button(
                'Proceed to Payment',
                onTap: () => context.pushOff(const AppScaffoldPage()),
              ),
              Gap.md,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.lockSimpleFill,
                    size: 18,
                    color: AppColors.palette[500],
                  ),
                  const Gap(4),
                  Text(
                    "This transaction is encrypted and secured.",
                    style: context.textTheme.caption
                        .changeColor(AppColors.palette[600]!),
                  )
                ],
              ),
              Gap.lg,
            ],
          )),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String _key, _value;
  final Widget? trailing;
  const Item(this._key, this._value, {this.trailing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_key,
              style: context.textTheme.bodyLarge
                  .changeColor(AppColors.primary)
                  .size(14)),
          if (trailing != null)
            trailing!
          else
            Text(_value,
                style: context.textTheme.bodyLarge
                    .changeColor(AppColors.primary)
                    .size(17)),
        ],
      ),
    );
  }
}
