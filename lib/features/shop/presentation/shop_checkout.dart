import 'dart:convert';
// import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fofo_app/config/api.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/notification.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/shop/presentation/shop.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout_addshipping.dart';
import 'package:fofo_app/features/shop/presentation/shop_checkout_delivery.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../service/shop/shop.dart';

String selectedItem = 'United States';
typedef OnSelectItem = Function(String? selectedItem);

class ShopCheckoutPage extends StatefulWidget {
  const ShopCheckoutPage({Key? key}) : super(key: key);

  @override
  State<ShopCheckoutPage> createState() => _ShopCheckoutPageState();
}

class _ShopCheckoutPageState extends State<ShopCheckoutPage> {
  late String country, city, address, postalCode;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Checkout"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.min,
            mainAxisSize: MainAxisSize.min,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select country'),
                    DropDownCategory(
                        selectedItem: selectedItem,
                        onSelectItem: (item) => {
                              setState(() => {selectedItem = item!})
                            }),
                  ],
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
              Gap.md,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInputField(
                      labelText: "City",
                      initialValue: "",
                      hintText: "",
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "City is required";
                        }
                      },
                      onSaved: (value) => city = value!,
                    ),
                    Gap.md,
                    TextInputField(
                      labelText: "Address",
                      initialValue: "",
                      hintText: "",
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Address is required";
                        }
                      },
                      onSaved: (value) => address = value!,
                    ),
                    Gap.md,
                    TextInputField(
                      labelText: "Postal code",
                      initialValue: "",
                      hintText: "",
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Postal code is required";
                        }
                      },
                      onSaved: (value) => postalCode = value!,
                    ),
                  ],
                ),
              ),
              Gap.lg,
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                child: Button(
                  "Proceed to Payment",
                  onTap: () async {
                    final form = _formKey.currentState!;
                    if (form.validate()) {
                      form.save();
                      await makePayment(context,
                          address: address,
                          country: selectedItem,
                          postalCode: postalCode,
                          city: city);
                    } else {
                      showNotification(context, false, "Invalid form");
                    }
                    // context.push(const CheckoutDeliveryPage());
                  },
                ),
              ),
              // const Gap(50)
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownCategory extends StatelessWidget {
  String? selectedItem;
  OnSelectItem onSelectItem;
  DropDownCategory(
      {Key? key, required this.selectedItem, required this.onSelectItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(247, 248, 250, 1),
        // border: Border.all(
        //     color: const Color.fromRGBO(196, 196, 196, 1), width: 1)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('Choose country'),
          ),
          style: const TextStyle(color: Colors.black),
          value: selectedItem,
          items: countries.map((itemy) {
            return DropdownMenuItem<String>(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(itemy),
              ),
              value: itemy,
            );
          }).toList(),
          onChanged: onSelectItem,
        ),
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

const List<String> countries = [
  'Afghanistan',
  'Åland Islands',
  'Albania',
  'Algeria',
  'American Samoa',
  'Andorra',
  'Angola',
  'Anguilla',
  'Antigua and Barbuda',
  'Argentina',
  'Armenia',
  'Aruba',
  'Australia',
  'Austria',
  'Azerbaijan',
  'Bangladesh',
  'Barbados',
  'Bahamas',
  'Bahrain',
  'Belarus',
  'Belgium',
  'Belize',
  'Benin',
  'Bermuda',
  'Bhutan',
  'Bolivia',
  'Bosnia and Herzegovina',
  'Botswana',
  'Brazil',
  'British Indian Ocean Territory',
  'British Virgin Islands',
  'Brunei Darussalam',
  'Bulgaria',
  'Burkina Faso',
  'Burma',
  'Burundi',
  'Cambodia',
  'Cameroon',
  'Canada',
  'Cape Verde',
  'Cayman Islands',
  'Central African Republic',
  'Chad',
  'Chile',
  'China',
  'Christmas Island',
  'Cocos (Keeling) Islands',
  'Colombia',
  'Comoros',
  'Congo-Brazzaville',
  'Congo-Kinshasa',
  'Cook Islands',
  'Costa Rica',
  'Cote d’Ivoire',
  'Croatia',
  'Curaçao',
  'Cyprus',
  'Czech Republic',
  'Denmark',
  'Djibouti',
  'Dominica',
  'Dominican Republic',
  'East Timor',
  'Ecuador',
  'El Salvador',
  'Egypt',
  'Equatorial Guinea',
  'Eritrea',
  'Estonia',
  'Ethiopia',
  'Falkland Islands',
  'Faroe Islands',
  'Federated States of Micronesia',
  'Fiji',
  'Finland',
  'France',
  'French Guiana',
  'French Polynesia',
  'French Southern Lands',
  'Gabon',
  'Gambia',
  'Georgia',
  'Germany',
  'Ghana',
  'Gibraltar',
  'Greece',
  'Greenland',
  'Grenada',
  'Guadeloupe',
  'Guam',
  'Guatemala',
  'Guernsey',
  'Guinea',
  'Guinea-Bissau',
  'Guyana',
  'Haiti',
  'Heard and McDonald Islands',
  'Honduras',
  'Hong Kong',
  'Hungary',
  'Iceland',
  'India',
  'Indonesia',
  'Iraq',
  'Ireland',
  'Isle of Man',
  'Israel',
  'Italy',
  'Jamaica',
  'Japan',
  'Jersey',
  'Jordan',
  'Kazakhstan',
  'Kenya',
  'Kiribati',
  'Kuwait',
  'Kyrgyzstan',
  'Laos',
  'Latvia',
  'Lebanon',
  'Lesotho',
  'Liberia',
  'Libya',
  'Liechtenstein',
  'Lithuania',
  'Luxembourg',
  'Macau',
  'Macedonia',
  'Madagascar',
  'Malawi',
  'Malaysia',
  'Maldives',
  'Mali',
  'Malta',
  'Marshall Islands',
  'Martinique',
  'Mauritania',
  'Mauritius',
  'Mayotte',
  'Mexico',
  'Moldova',
  'Monaco',
  'Mongolia',
  'Montenegro',
  'Montserrat',
  'Morocco',
  'Mozambique',
  'Namibia',
  'Nauru',
  'Nepal',
  'Netherlands',
  'New Caledonia',
  'New Zealand',
  'Nicaragua',
  'Niger',
  'Nigeria',
  'Niue',
  'Norfolk Island',
  'Northern Mariana Islands',
  'Norway',
  'Oman',
  'Pakistan',
  'Palau',
  'Panama',
  'Papua New Guinea',
  'Paraguay',
  'Peru',
  'Philippines',
  'Pitcairn Islands',
  'Poland',
  'Portugal',
  'Puerto Rico',
  'Qatar',
  'Réunion',
  'Romania',
  'Russia',
  'Rwanda',
  'Saint Barthélemy',
  'Saint Helena',
  'Saint Kitts and Nevis',
  'Saint Lucia',
  'Saint Martin',
  'Saint Pierre and Miquelon',
  'Saint Vincent',
  'Samoa',
  'San Marino',
  'São Tomé and Príncipe',
  'Saudi Arabia',
  'Senegal',
  'Serbia',
  'Seychelles',
  'Sierra Leone',
  'Singapore',
  'Sint Maarten',
  'Slovakia',
  'Slovenia',
  'Solomon Islands',
  'Somalia',
  'South Africa',
  'South Georgia',
  'South Korea',
  'Spain',
  'Sri Lanka',
  'Sudan',
  'Suriname',
  'Svalbard and Jan Mayen',
  'Sweden',
  'Swaziland',
  'Switzerland',
  'Syria',
  'Taiwan',
  'Tajikistan',
  'Tanzania',
  'Thailand',
  'Togo',
  'Tokelau',
  'Tonga',
  'Trinidad and Tobago',
  'Tunisia',
  'Turkey',
  'Turkmenistan',
  'Turks and Caicos Islands',
  'Tuvalu',
  'Uganda',
  'Ukraine',
  'United Arab Emirates',
  'United Kingdom',
  'United States',
  'Uruguay',
  'Uzbekistan',
  'Vanuatu',
  'Vatican City',
  'Vietnam',
  'Venezuela',
  'Wallis and Futuna',
  'Western Sahara',
  'Yemen',
  'Zambia',
  'Zimbabwe'
];

Future<void> makePayment(BuildContext context,
    {required String address,
    required String country,
    required String postalCode,
    required String city}) async {
  var cart = Provider.of<ShopProvider>(context, listen: false).cart;
  List products = [];
  double total = 0;
  for (var item in cart) {
    Map hold = {
      'productId': item['id'],
      'name': item['name'],
      'qty': item['quantity'],
      'price': item['variation']['price'],
      'size': item['variation']['size'],
      'color': item['color']
    };
    total += item['variation']['price'];
    products.add(hold);
  }

  Map shipping = {
    "address": address,
    "city": city,
    "postalCode": postalCode,
    "country": country,
    "paymentMethod": "Stripe"
  };

  Map details = {
    "orderItems": products,
    "shippingAddress": shipping,
    "taxPrice": 0,
    "shippingPrice": 0,
    "itemsPrice": total,
    "totalPrice": total,
    "action": "shop"
  };
  print('checkout ttss');
  print(details);

  try {
    EasyLoading.show(status: 'loading...');
    print('pay intro');
    DioClient dioClient = DioClient(Dio());
    Response response = await dioClient
        .post(context, "stripe/order-checkout", data: {"product": details});

    print("checkout resp");
    print(response.data);
    print(response.data['paymentIntent']);
    if (response.data != null) {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        testEnv: true,
        merchantCountryCode: 'US',
        merchantDisplayName: 'Trail Blazer',
        customerId: response.data!['customerId'],
        paymentIntentClientSecret: response.data['paymentIntent'],
        customerEphemeralKeySecret: response.data['ephemeralKey'],
      ));
      EasyLoading.dismiss();
      displayPaymentSheet(context);
    }
  } catch (err) {
    EasyLoading.dismiss();
    print('init pay err');
    print(err);
  }
}

displayPaymentSheet(context) async {
  try {
    print('before pps');
    await Stripe.instance.presentPaymentSheet();
    Provider.of<ShopProvider>(context, listen: false).clearCart();
    showNotification(context, true, "Payment successful");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const ShopPage(),
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
