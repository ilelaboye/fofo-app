import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';

class PinInput extends StatelessWidget {
  void Function(String) onChange;
  PinInput({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle:
          context.textTheme.headlineLarge!.changeColor(AppColors.palette[300]!),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: AppColors.palette[300]!,
          width: 3,
        )),
      ),
    );

    final focusedPinTheme = defaultPinTheme
        .copyWith(
          textStyle:
              context.textTheme.headlineLarge!.changeColor(AppColors.primary),
        )
        .copyDecorationWith(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary,
              width: 3,
            ),
          ),
        );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      submittedPinTheme: focusedPinTheme,
      focusedPinTheme: focusedPinTheme,
      onChanged: onChange,
      preFilledWidget: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: AppColors.palette[300]!,
          shape: BoxShape.circle,
        ),
      ),
      onCompleted: (pin) => {},
    );
  }
}
