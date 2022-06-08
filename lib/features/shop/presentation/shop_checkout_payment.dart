import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout_complete.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CheckoutPaymentPage extends StatefulWidget {
  const CheckoutPaymentPage({Key? key}) : super(key: key);

  @override
  _CheckoutPaymentPageState createState() => _CheckoutPaymentPageState();
}

class _CheckoutPaymentPageState extends State<CheckoutPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Checkout"),
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
                    const Item("SUBTOTAL", "\$45.00"),
                    Item(
                      "SHIPPING",
                      "",
                      trailing: Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Express: \$45.00 delivering to 15th avenue New York",
                              style: context.textTheme.bodyLarge
                                  .changeColor(AppColors.primary)
                                  .size(17),
                            ),
                            Gap.sm,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text("Change Address"),
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
                    ),
                    const Divider(),
                    const Item("ORDER TOTAL", "\$45.00"),
                  ],
                ),
              ),
              Gap.lg,
              Button(
                'Proceed to Payment',
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => const PaymentCardBottomSheet(),
                ),
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
            Expanded(child: trailing!)
          else
            Text(
              _value,
              style: context.textTheme.bodyLarge
                  .changeColor(AppColors.primary)
                  .size(17),
            ),
        ],
      ),
    );
  }
}

class PaymentCardBottomSheet extends StatefulWidget {
  const PaymentCardBottomSheet({Key? key}) : super(key: key);

  @override
  State<PaymentCardBottomSheet> createState() => _PaymentCardBottomSheetState();
}

class _PaymentCardBottomSheetState extends State<PaymentCardBottomSheet> {
  bool hasAddedCard = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(Insets.md, 0, Insets.md, Insets.lg),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
      ),
      padding: const EdgeInsets.all(Insets.lg),
      child: Material(
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            hasAddedCard
                ? const PaymentCardAddedModal()
                : AddPaymentCardModal(onAdd: () {
                    setState(() {
                      hasAddedCard = true;
                    });
                  }),
            Positioned(
              child: Icon(
                PhosphorIcons.xCircleFill,
                color: AppColors.primary,
              ).onTap(() => context.pop()),
            )
          ],
        ),
      ),
    );
  }
}

class AddPaymentCardModal extends StatelessWidget {
  final Function onAdd;
  const AddPaymentCardModal({required this.onAdd, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(PhosphorIcons.creditCardThin, size: 100),
        Gap.sm,
        Text(
          "Add This Card",
          style: context.textTheme.headlineSmall.bold
              .changeColor(AppColors.primary),
          textAlign: TextAlign.center,
        ),
        Gap.sm,
        Text(
          "Add this card for future purchases, this is to make payment easier to avoid asking for dedit card details",
          textAlign: TextAlign.center,
          style: context.textTheme.caption
              .changeColor(AppColors.palette[600])
              .copyWith(height: 1.4),
        ),
        Gap.lg,
        Button(
          "Add This Card",
          onTap: () => onAdd(),
        )
      ],
    );
  }
}

class PaymentCardAddedModal extends StatelessWidget {
  const PaymentCardAddedModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(PhosphorIcons.checkCircleThin, size: 100),
          Gap.sm,
          Text(
            "Successfully Added",
            style: context.textTheme.headlineSmall.bold
                .changeColor(AppColors.primary),
            textAlign: TextAlign.center,
          ),
          Gap.sm,
          Text(
            "This debit card has been added successfully.",
            textAlign: TextAlign.center,
            style: context.textTheme.caption
                .changeColor(AppColors.palette[600])
                .copyWith(height: 1.4),
          ),
          Gap.lg,
          Button(
            "Close",
            onTap: () {
              context.pop();
              context.push(const CheckoutCompletePage());
            },
          )
        ]);
  }
}
