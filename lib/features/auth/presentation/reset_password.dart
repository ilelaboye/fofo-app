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
import 'package:fofo_app/service/auth_service/auth_provider.dart';
import 'package:provider/provider.dart';

class StartResetPasswordPage extends StatefulWidget {
  const StartResetPasswordPage({Key? key}) : super(key: key);

  @override
  _StartResetPasswordPageState createState() => _StartResetPasswordPageState();
}

class _StartResetPasswordPageState extends State<StartResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  late String email;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const AuthHeading(
                  "Reset password",
                  "Let us help you get access to your account by helping you to reset your password.",
                ),
                Gap.lg,
                TextInputField(
                  onSaved: (value) => email = value!,
                  labelText: "Email Address",
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
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      form.save();
                      auth.resetPassword(context, email);
                      context.push(OtpPage(
                          otpState: OtpState.resetPassword,
                          email: email,
                          user: {'email': email}));
                    }
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
  String? errorConfirmPassword;
  final formKey = new GlobalKey<FormState>();
  late String password, confirmPassword;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final user = Provider.of<AuthProvider>(context).authUser;
    return Scaffold(
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const AuthHeading(
                  "Reset password",
                  "Let us help you get access to your account by helping you to reset your password.",
                ),
                Gap.lg,
                TextInputField(
                  labelText: "Password",
                  onSaved: (value) => password = value!,
                  validator: (value) {
                    password = value!;
                    if (value.isNotEmpty) {
                      return null;
                    } else {
                      return "Please Input Password";
                    }
                  },
                ),
                const Gap(25),
                TextInputField(
                  labelText: "Confirm Password",
                  onSaved: (value) => confirmPassword = value!,
                  validator: (value) {
                    setState(() {
                      if (password != value && value!.isEmpty) {
                        errorConfirmPassword = 'Password mismatch';
                      } else {
                        errorConfirmPassword = null;
                      }
                    });
                  },
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
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      form.save();
                      if (user?.userId != null) {
                        auth.updatePassword(
                            context, password, confirmPassword, user!.userId!);
                        context.pushOff(const LoginPage());
                      }
                    }
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
