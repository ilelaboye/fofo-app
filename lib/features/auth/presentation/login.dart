import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/auth/presentation/reset_password.dart';
import 'package:fofo_app/features/auth/presentation/signup.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const AuthHeading(
                "Welcome back",
                "Sign into your account to continue from where you left off.",
              ),
              Gap.lg,
              TextInputField(
                labelText: "Email Address",
                hintText: "E.g Rachelchoo@gmail.com",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Password",
                suffixIcon: Icon(
                  PhosphorIcons.eyeSlashFill,
                  color: AppColors.primary,
                ),
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
                        ..onTap =
                            () => context.push(const StartResetPasswordPage()),
                    ),
                  ],
                ),
                style: context.textTheme.caption,
              ),
              Gap.lg,
              Button(
                'Sign In',
                onTap: () => context.pushOff(const AppScaffoldPage()),
              ),
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
    );
  }
}
