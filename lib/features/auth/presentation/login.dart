import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/auth/presentation/reset_password.dart';
import 'package:fofo_app/features/auth/presentation/signup.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/app/app_scaffold.dart';
import '../../../core/widgets/notification.dart';
import '../../../service/auth_service/auth_provider.dart';

class LoginPage extends StatefulWidget {
  static const String route = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late String email, password;
  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    return Scaffold(
      // appBar: const Appbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(Insets.lg),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeading(
                      "Welcome back",
                      "Sign into your account to continue from where you left off.",
                    ),
                    Gap.lg,
                    TextInputField(
                      validator: (value) =>
                          value!.isEmpty ? "Please enter email" : null,
                      // validator: validateEmail,
                      onSaved: (value) => email = value!,
                      initialValue: "",
                      labelText: "Email Address",
                      hintText: "E.g Rachelchoo@gmail.com",
                    ),
                    const Gap(25),
                    TextInputField(
                      validator: (value) =>
                          value!.isEmpty ? "Please enter password" : null,
                      onSaved: (value) => password = value!,
                      initialValue: "",
                      labelText: "Password",
                      obscureText: passenable,
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
                    ),
                    const Gap(25),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Forgot password ? "),
                          TextSpan(
                            text: "Reset Password Here",
                            style: context.textTheme.caption!
                                .changeColor(AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  context.push(const StartResetPasswordPage()),
                          ),
                        ],
                      ),
                      style: context.textTheme.caption,
                    ),
                    Gap.lg,
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : Button('Sign In', onTap: () async {
                            print('login cliked');
                            final form = formKey.currentState!;
                            if (form.validate()) {
                              form.save();
                              await auth
                                  .login(context, email, password)
                                  .then((response) => {
                                        if (response['status'])
                                          {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AppScaffoldPage()),
                                                    (route) => false)
                                          }
                                        else
                                          {
                                            showNotification(context, false,
                                                response['message'])
                                          }
                                      });
                            } else {
                              showNotification(
                                  context, false, "Invalid form input");
                            }
                          }),
                    const Gap(25),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Don’t have an account ?"),
                          TextSpan(
                            text: " Register Here",
                            style: context.textTheme.caption!
                                .changeColor(AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.push(const SignupPage()),
                          ),
                        ],
                      ),
                      style: context.textTheme.caption,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
