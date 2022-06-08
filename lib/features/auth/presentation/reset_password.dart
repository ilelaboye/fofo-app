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
import 'package:fofo_app/features/auth/presentation/login.dart';
import 'package:fofo_app/features/auth/presentation/otp.dart';

class StartResetPasswordPage extends StatefulWidget {
  const StartResetPasswordPage({Key? key}) : super(key: key);

  @override
  _StartResetPasswordPageState createState() => _StartResetPasswordPageState();
}

class _StartResetPasswordPageState extends State<StartResetPasswordPage> {
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
                  "Reset password",
                  "Let us help you get access to your account by helping you to reset your password.",
                ),
                Gap.lg,
                TextInputField(
                  labelText: "Registered Email Address",
                  hintText: "E.g Rachelchoo@gmail.com",
                ),
                const Gap(25),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Already have an account ? "),
                      TextSpan(
                        text: "Login Here",
                        style: context.textTheme.caption
                            .changeColor(AppColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.pushOff(const LoginPage()),
                      ),
                    ],
                  ),
                  style: context.textTheme.caption,
                ),
                Gap(context.getHeight(0.4)),
                Button(
                  'Check Email',
                  onTap: () {
                    context.push(const OtpPage(
                      otpState: OtpState.resetPassword,
                    ));
                  },
                ),
                const Gap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EndResetPasswordPage extends StatefulWidget {
  const EndResetPasswordPage({Key? key}) : super(key: key);

  @override
  _EndResetPasswordPageState createState() => _EndResetPasswordPageState();
}

class _EndResetPasswordPageState extends State<EndResetPasswordPage> {
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
                  "Reset password",
                  "Let us help you get access to your account by helping you to reset your password.",
                ),
                Gap.lg,
                TextInputField(
                  labelText: "Password",
                ),
                const Gap(25),
                TextInputField(
                  labelText: "Confirm Password",
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
                          ..onTap = () => context.pushOff(const LoginPage()),
                      ),
                    ],
                  ),
                  style: context.textTheme.caption,
                ),
                Gap(context.getHeight(0.3)),
                Button(
                  'Reset Password',
                  onTap: () {
                    context.pushOff(const LoginPage());
                  },
                ),
                const Gap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
