// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/constants/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/notification.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/auth/presentation/login.dart';
import 'package:fofo_app/features/subscription/presentation/subscription.dart';
// import 'package:fofo_app/service/auth_service/auth_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service/auth_provider.dart';
import '../../public/terms.dart';
import 'otp.dart';

String? selectedItem;
typedef OnSelectItem = Function(String? selectedItem);
const List<String> Items = [
  'Agriculture',
  'Architecture and engineering',
  'Arts (Culture and entertainment)',
  'Business (Management and administration)',
  'Communications',
  'Community and Social Services',
  'Education',
  'Health and Medicine',
  'Human Resources',
  'Government',
  'Law and Public policy',
  'Real Estate',
  'Sales and Marketing',
  'Science',
  'Technology'
];

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late String fullname, email, phonenumber, password;
  bool passenable = true;
  bool terms = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    auth.skipOnboarding();
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    // final ISignUp _signupService = SignUpService();
    // final notify = Notification();
    return Scaffold(
      // appBar: const Appbar(hasLeading: false),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const AuthHeading(
                      "Create Account",
                      "Sign up to see how We can help you build, expand and sustain your career in any industry.",
                    ),
                    Gap.lg,
                    TextInputField(
                      labelText: "Full Name",
                      initialValue: "",
                      hintText: "E.g Rachel Choo",
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Please Input Fullname";
                        }
                      },
                      onSaved: (value) => fullname = value!,
                    ),
                    const Gap(25),
                    TextInputField(
                        labelText: "Email Address",
                        initialValue: "",
                        hintText: "E.g Rachelchoo@gmail.com",
                        onSaved: (value) => email = value!,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "Please Input Email";
                          }
                        }),
                    const Gap(25),
                    TextInputField(
                      labelText: "Phone Number",
                      initialValue: "",
                      hintText: "(country code) 1234567890",
                      onSaved: (value) => phonenumber = value!,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length > 5) {
                          return null;
                        } else if (value.length < 5 && value.isNotEmpty) {
                          return "Invalid phone Number";
                        } else {
                          return "Please Input Phone Number";
                        }
                      },
                      prefix: Container(
                        width: 50,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        color: AppColors.dark,
                        child: Center(
                            child: Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        )),
                      ),
                    ),
                    const Gap(25),
                    DropDownCategory(
                        selectedItem: selectedItem,
                        onSelectItem: (item) => {
                              setState(() => {selectedItem = item})
                            }),
                    const Gap(25),
                    TextInputField(
                        obscureText: passenable,
                        labelText: "Password",
                        initialValue: "",
                        suffixIcon: Icon(
                          PhosphorIcons.eyeSlashFill,
                          color: AppColors.primary,
                        ).onTap(() {
                          setState(() {
                            if (passenable) {
                              passenable = false;
                            } else {
                              passenable = true;
                            }
                          });
                        }),
                        onSaved: (value) => password = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Input Password";
                          }
                          if (value.length < 7) {
                            return "Minimum of 7 characters is required";
                          }

                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: AppColors.primary,
                                value: terms,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    terms = value!;
                                  });
                                },
                              )),
                          Expanded(
                            child: Text(
                              'I agree to the Trailblazer Terms and Condition',
                              style: TextStyle(color: AppColors.primary),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 2,
                            ).onTap(() {
                              context.push(const TermsCondition());
                            }),
                          ),
                        ],
                      ),
                    ),
                    const Gap(25),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Already have an account ? "),
                          TextSpan(
                            text: "Login Here",
                            style: context.textTheme.caption!
                                .changeColor(AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.push(const LoginPage()),
                          )
                        ],
                      ),
                      style: context.textTheme.caption,
                    ),
                    Gap.lg,
                    auth.registeredInStatus == Status.Loading
                        ? loading
                        : Button(
                            'Create Your Account',
                            onTap: () {
                              final form = _formKey.currentState!;
                              if (!terms) {
                                showNotification(context, false,
                                    "Agree to terms and condition");
                                return;
                              }
                              if (form.validate()) {
                                form.save();
                                auth
                                    .register(
                                        context,
                                        fullname,
                                        email,
                                        phonenumber,
                                        selectedItem.toString(),
                                        password)
                                    .then((response) {
                                  print('signup response');
                                  print(response);
                                  if (response['status']) {
                                    Map user = response['data'];
                                    // Provider.of<UserProvider>(context,
                                    //         listen: false)
                                    //     .setUser(user);
                                    if (user['stage'] == 1) {
                                      context.push(OtpPage(
                                          otpState: OtpState.auth,
                                          email: email,
                                          phone: phonenumber,
                                          user: user));
                                    } else if (user['stage'] == 2) {
                                      context.push(SubscriptionPage(
                                        user: user,
                                      ));
                                    }
                                  } else {
                                    showNotification(
                                        context, false, response['message']);
                                  }
                                });
                              } else {
                                showNotification(
                                    context, false, "Invalid form");
                              }
                            },
                          ),
                    const Gap(50),
                  ],
                )),
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
          hint: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text('choose your kind of business'),
          ),
          style: TextStyle(color: Colors.black),
          value: selectedItem,
          items: Items.map((itemy) {
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
