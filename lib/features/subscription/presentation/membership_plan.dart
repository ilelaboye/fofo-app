import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../config/api.dart';
import '../../../core/presentation/app/app_scaffold.dart';
import '../../../core/widgets/notification.dart';

class MembershipPlanPage extends StatefulWidget {
  final String membershipId;
  final String membershipType;
  final List<dynamic> perks;
  final double fee;
  final double pricePerYear;
  final double pricePerMonth;
  final String title, desc, benefit;
  final Map user;
  MembershipPlanPage(this.perks,
      {Key? key,
      required this.membershipId,
      required this.membershipType,
      this.fee = 0,
      this.pricePerYear = 0,
      this.pricePerMonth = 0,
      this.title = "Access",
      this.desc = "",
      this.benefit = '',
      required this.user})
      : super(key: key);

  @override
  State<MembershipPlanPage> createState() => _MembershipPlanPageState();
}

class _MembershipPlanPageState extends State<MembershipPlanPage> {
  Map<String, dynamic>? paymentIntentData;
  bool yearState = true;
  double yearAmount = 250;

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
            child: widget.fee != 0
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        yearState
                            ? "\$${widget.pricePerYear}"
                            : "\$${widget.pricePerMonth}",
                        style: context.textTheme.headlineLarge
                            .changeColor(AppColors.primary),
                      ),
                      Gap.sm,
                      Text(
                        yearState ? "/ Year" : "/ Month",
                        style: context.textTheme.bodyMedium
                            .changeColor(AppColors.primary),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text('Y'),
                          CupertinoSwitch(
                            activeColor: AppColors.primary,
                            value: yearState ? false : true,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                yearState = !value;
                                if (yearState == false) {
                                  yearAmount = widget.pricePerMonth;
                                } else {
                                  yearAmount = widget.pricePerYear;
                                }
                                print(yearState);
                                print(yearAmount);
                              });
                            },
                          ),
                          Text('M'),
                        ],
                      )
                    ],
                  )
                : Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Free",
                      style: context.textTheme.headlineLarge!
                          .changeColor(AppColors.primary)
                          .bold,
                    ),
                  ),
          ),
          widget.fee != 0
              ? Padding(
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
                          "You save \$${(widget.pricePerMonth * 12) - widget.pricePerYear} & you get 2 months subscription free",
                          style: context.textTheme.caption!
                              .changeColor(const Color(0xff40BF95)),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: context.textTheme.headlineMedium
                      .changeColor(AppColors.primary)
                      .size(24)
                      .bold,
                ),
                Gap.sm,
                Text(
                  widget.desc,
                  style: context.textTheme.bodyMedium
                      .changeColor(AppColors.palette[700]!)
                      .size(12)
                      .copyWith(height: 1.4),
                ),
                Gap.md,
                const SectionHeader("Benefits"),
                Gap.sm,
                Text(
                  widget.benefit,
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
                  seeAll: false,
                ),
                Gap.sm,
                AvatarGroup(AppColors.colorList()),
                Gap.md,
                // const SectionHeader("Reviews"),
                // Gap.sm,
              ],
            ),
          ),
          // const ReviewList(),
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Button("Choose This Plan", onTap: () async {
              if (widget.fee > 0) {
                print('ll');
                print(widget.user);
                print(yearAmount);
                await makePayment(
                  membershipId: widget.membershipId,
                  membershipType: widget.membershipType,
                  amount: yearAmount.toString(),
                  currency: 'USD',
                  user: widget.user,
                );
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const AppScaffoldPage(),
                  ),
                  (route) => false,
                );
              }

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
      {required membershipId,
      required membershipType,
      required String amount,
      required String currency,
      required Map user}) async {
    print(amount);
    try {
      EasyLoading.show(status: 'loading...');
      print('pay intro');
      // var userId = user['userId'];
      // if (userId == null) {
      //   userId = user['id'];
      // }
      // print(userId);
      DioClient dioClient = DioClient(Dio());
      Response response =
          await dioClient.post(context, "stripe/membership-checkout", data: {
        "membership": {
          'amount': amount,
          'membershipId': membershipId,
          'mode': yearState ? "yearly" : "monthly",
          'membershipType': membershipType,
        }
      });

      print("pay resp");
      print(response.data);
      print(response.data['paymentIntent']);
      if (response.data != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: response.data!['customerId'],
          paymentIntentClientSecret: response.data['paymentIntent'],
          customerEphemeralKeySecret: response.data['ephemeralKey'],
        ));
        EasyLoading.dismiss();
        displayPaymentSheet();
      }
    } catch (err) {
      EasyLoading.dismiss();
      print('init pay err');
      print(err);
      // _loggedInStatus = Status.NotLoggedIn;
      // notifyListeners();
      // return {'status': false, 'message': err};
    }
    // try {
    //   paymentIntentData = await createPaymentIntent(amount, currency);
    //   print('paym int');
    //   print(paymentIntentData);
    //   if (paymentIntentData != null) {
    //     await Stripe.instance.initPaymentSheet(
    //         paymentSheetParameters: SetupPaymentSheetParameters(
    //       applePay: true,
    //       googlePay: true,
    //       testEnv: true,
    //       merchantCountryCode: 'US',
    //       merchantDisplayName: 'Prospects',
    //       customerId: paymentIntentData!['customer'],
    //       paymentIntentClientSecret: paymentIntentData!['client_secret'],
    //       customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
    //     ));
    //     displayPaymentSheet();
    //   }
    // } catch (e, s) {
    //   print('exception:$e$s');
    // }
  }

  displayPaymentSheet() async {
    try {
      print('before pps');
      await Stripe.instance.presentPaymentSheet();
      showNotification(context, true, "Payment successful");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AppScaffoldPage(),
        ),
        (route) => false,
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        showNotification(
            context, false, "Error from Stripe: ${e.error.localizedMessage}");
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        showNotification(context, false, "Unforeseen error: ${e}");
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      showNotification(context, false, "exception:$e");
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
      showNotification(
          context, false, 'Error charging user: ${err.toString()}');
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
