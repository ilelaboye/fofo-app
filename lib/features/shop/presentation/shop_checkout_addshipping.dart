import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';

class AddshippingAddressPage extends StatelessWidget {
  const AddshippingAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _border = OutlineInputBorder(
      borderRadius: Corners.xsBorder,
      borderSide: BorderSide(
        color: AppColors.palette[50]!,
        width: 1.2,
      ),
    );
    return Scaffold(
      appBar: const Appbar(title: "Checkout"),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Shipping Address",
              style: context.textTheme.headlineMedium.bold
                  .size(24)
                  .changeColor(AppColors.primary),
            ),
            Gap.lg,
            TextFormField(
              maxLines: 5,
              style: context.textTheme.bodyText1,
              decoration: InputDecoration(
                hintText: "E.g 15th avenue New York city",
                errorStyle: context.textTheme.bodyMedium
                    .size(15)
                    .changeColor(AppColors.error),
                hintStyle: context.textTheme.bodyMedium!
                    .size(15)
                    .changeColor(AppColors.palette[500]!),
                fillColor: AppColors.palette[50],
                filled: true,
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: _border,
                enabledBorder: _border,
                errorBorder: _border,
                focusedErrorBorder: _border,
                focusedBorder: _border.copyWith(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 0.8,
                  ),
                ),
              ),
            ),
            Gap.lg,
            const Spacer(),
            Button(
              "Add Shipping Address",
              onTap: () => context.pop(),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}
