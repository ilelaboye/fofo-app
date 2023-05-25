import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/pinput.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/auth/presentation/profile_picture_upload.dart';
import 'package:fofo_app/features/auth/presentation/reset_password.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/notification.dart';
import '../../../service/auth_service/auth_provider.dart';

enum OtpState { auth, resetPassword }

class OtpPage extends StatefulWidget {
  final OtpState otpState;
  const OtpPage(
      {this.otpState = OtpState.auth,
      Key? key,
      required this.email,
      required this.user,
      this.phone = ""})
      : super(key: key);
  final String email;
  final String phone;
  final Map user;
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final formKey = GlobalKey<FormState>();
  late String otp;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
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
                AuthHeading(
                  "OTP Verification",
                  "Check your email. We’ve just sent you the Four (4) digit pin at (+) " +
                      widget.phone,
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
                          auth.resetPassword(context, widget.email);
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
                "Verify OTP Code",
                onTap: () {
                  final form = formKey.currentState!;
                  if (form.validate()) {
                    form.save();
                    print('response otp');
                    print(otpState);
                    print(widget.user);
                    EasyLoading.show(status: 'loadings...');
                    if (otpState == OtpState.resetPassword) {
                      if (widget.user['accessToken'] != null) {
                        auth.verifyOtp(
                            context, otp, widget.user['accessToken']!);
                        EasyLoading.dismiss();
                        context.push(const EndResetPasswordPage());
                      }
                    }
                    if (otpState == OtpState.auth) {
                      print('otp auth');
                      if (widget.user['accessToken'] != null) {
                        auth
                            .verifyOtp(context, otp, widget.user['accessToken'])
                            .then((response) {
                          EasyLoading.dismiss();
                          print('otp verify resp');
                          print(response);
                          if (response['status']) {
                            showNotification(
                                context, true, "Otp verified successfully");
                            context.push(
                                ProfilePictureUploadPage(user: widget.user));
                          } else {
                            EasyLoading.dismiss();
                            showNotification(
                                context, false, response['message']);
                          }
                        });
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
