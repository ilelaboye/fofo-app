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
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                "Create Account",
                "Sign up to see how We can help you build, expand and sustain your career in any industry.",
              ),
              Gap.lg,
              TextInputField(
                labelText: "Full Name",
                hintText: "E.g Rachel Choo",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Email Address",
                hintText: "E.g Rachelchoo@gmail.com",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Phone Number",
                hintText: "E.g 1234567890",
                prefix: ClipRRect(
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: Insets.sm),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Corners.xsRadius,
                          bottomLeft: Corners.xsRadius,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "+234",
                          style: context.textTheme.bodyMedium!
                              .size(16)
                              .changeColor(Colors.white),
                        ),
                        const Icon(
                          PhosphorIcons.caretDown,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(25),
              TextInputField(
                labelText: "Field",
                hintText: "Select your field",
                suffixIcon: Icon(
                  PhosphorIcons.caretDown,
                  color: AppColors.primary,
                ),
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
              Button(
                'Create Your Account',
                onTap: () => context.push(const OtpPage()),
              ),
              const Gap(50)
            ],
          )),
        ),
      ),
    );
  }
}
