import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/constants/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/pinput.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/auth/presentation/profile_picture_upload.dart';
import 'package:fofo_app/features/auth/presentation/reset_password.dart';
import 'package:fofo_app/service/auth_service/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/app/app_scaffold.dart';
import '../../../service/auth_service/auth_provider.dart';

enum OtpState { auth, resetPassword }

class OtpPage extends StatefulWidget {
  final OtpState otpState;
  const OtpPage({this.otpState = OtpState.auth, Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final formKey = GlobalKey<FormState>();
  late String otp;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final user = Provider.of<AuthProvider>(context).authUser;
    final otpState = widget.otpState;
    return Scaffold(
      appBar: const Appbar(),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if (otpState == OtpState.auth)
                const AuthHeading(
                  "OTP Verification",
                  "Check your SMS messages. We’ve just sent you the Four (4) digit pin at (+1) 1234567890",
                ),
              if (otpState == OtpState.resetPassword)
                const AuthHeading(
                  "Reset OTP",
                  "Let us help you get access to your account by helping you to reset your password.",
                ),
              Gap.lg,
              // pinput
              PinInput(
                onChange: (value) => otp = value,
              ),
              const Gap(25),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: "Didnt receive any code ?\n"),
                    TextSpan(
                      text: "Resend Code",
                      style: context.textTheme.caption!
                          .changeColor(AppColors.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          auth.resetPassword(widget.email);
                          context.pop();
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: context.textTheme.caption,
              ),
              const Spacer(),
              Button(
                "Verify OTP Code Now",
                onTap: () {
                  final form = formKey.currentState!;
                  if (form.validate()) {
                    form.save();
                    if (otpState == OtpState.resetPassword) {
                      if (user?.accessToken != null) {
                        auth.verifyOtp(otp, user!.accessToken!);
                        context.push(const EndResetPasswordPage());
                      }
                    }
                    if (otpState == OtpState.auth) {
                      if (user?.accessToken != null) {
                        auth.verifyOtp(otp, user!.accessToken!);
                        context.push(const ProfilePictureUploadPage());
                      }
                    }
                  }
                },
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
