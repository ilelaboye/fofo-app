import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class JobApplicationSuccessPage extends StatelessWidget {
  const JobApplicationSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Application"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(Insets.lg),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primary),
              child: const Icon(
                PhosphorIcons.checkLight,
                color: Colors.white,
                size: 50,
              ),
            ),
            Gap.lg,
            Text(
              "Successful application",
              style: context.textTheme.headlineSmall.bold
                  .changeColor(AppColors.primary),
            ),
            Gap.xs,
            Text(
              "Your job application was successful, check your email for application details,",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium
                  .changeColor(AppColors.palette[600])
                  .copyWith(height: 1.8),
            ),
            Gap.lg,
            Button(
              "Continue Applying",
              onTap: () => context.pushOff(const AppScaffoldPage()),
            )
          ],
        ),
      ),
    );
  }
}
