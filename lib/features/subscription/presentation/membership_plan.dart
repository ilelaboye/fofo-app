import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/review.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/subscription/presentation/checkout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../core/presentation/app/app_scaffold.dart';

class MembershipPlanPage extends StatefulWidget {
  final List<String> perks;
  MembershipPlanPage(this.perks, {Key? key}) : super(key: key);

  @override
  State<MembershipPlanPage> createState() => _MembershipPlanPageState();
}

class _MembershipPlanPageState extends State<MembershipPlanPage> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    // final paymentController = PaymentController();
    return Scaffold(
      appBar: const Appbar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Gap.md,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$250",
                  style: context.textTheme.headlineLarge
                      .changeColor(AppColors.primary),
                ),
                Gap.sm,
                Text(
                  "/ Year",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.primary),
                ),
                const Spacer(),
                CupertinoSwitch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (value) {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Insets.lg, vertical: Insets.xs),
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.infoFill,
                  size: 18,
                  color: AppColors.palette[500],
                ),
                const Gap(4),
                Expanded(
                  child: Text(
                    "You save \$50 & you get 2 months subscription free",
                    style: context.textTheme.caption!
                        .changeColor(const Color(0xff40BF95)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gold Access",
                  style: context.textTheme.headlineMedium
                      .changeColor(AppColors.primary)
                      .size(24)
                      .bold,
                ),
                Gap.sm,
                Text(
                  "Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success. We’ll help you and clarify your purpose, overcome impostor syndr see more...",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.palette[700]!)
                      .size(12)
                      .copyWith(height: 1.4),
                ),
                Gap.md,
                const SectionHeader("Benefits"),
                Gap.sm,
                Text(
                  "Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success. We’ll help you and clarify your purpose, overcome impostor syndr see more...",
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.palette[700]!)
                      .size(12)
                      .copyWith(height: 1.4),
                ),
                Gap.sm,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.perks.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: Insets.sm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        Gap.sm,
                        Expanded(
                          child: Text(
                            widget.perks[index],
                            style: context.textTheme.bodyMedium
                                .changeColor(AppColors.palette[700]!)
                                .size(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SectionHeader(
                  "Members",
                  seeAll: true,
                ),
                Gap.sm,
                AvatarGroup(AppColors.colorList()),
                Gap.md,
                const SectionHeader("Reviews"),
                Gap.sm,
              ],
            ),
          ),
          const ReviewList(),
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Button("Choose This Plan", onTap: () async {
              await makePayment(amount: '2', currency: 'USD');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AppScaffoldPage(),
                ),
                (route) => false,
              );
              //  context.pushOff(const AppScaffoldPage());
            }
                // context.push(const CheckoutPage()),
                ),
          ),
          Gap.lg,
        ],
      )),
    );
  }

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Kzz4mBSyohQ7ttboR1bDzNHyQ168aa2VLrSYUuCcdZ4gHeYzsX05RkTW4iiQTYupP9DQF8yqxNnoFOFZ4fiGnnf00yMRnRuRj',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
