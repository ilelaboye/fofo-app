import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/jobs/presentation/job_application_document_upload.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class JobApplicationFormPage extends StatefulWidget {
  const JobApplicationFormPage({Key? key}) : super(key: key);

  @override
  _JobApplicationFormPageState createState() => _JobApplicationFormPageState();
}

class _JobApplicationFormPageState extends State<JobApplicationFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Application"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Form(
              child: Column(
            children: [
              const AuthHeading(
                "Confirm details",
                "Confirm and edit your application details below, details were gotten from your profile.",
              ),
              Gap.lg,
              TextInputField(
                labelText: "Full Name",
                hintText: "E.g Rachel Choo",
                initialValue: "Rachel Choo",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Email Address",
                hintText: "E.g Rachelchoo@gmail.com",
                initialValue: "Rachelchoo@gmail.com",
              ),
              const Gap(25),
              TextInputField(
                labelText: "Phone Number",
                hintText: "E.g 1234567890",
                initialValue: "1234567890",
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
                labelText: "Availability",
                hintText: "Select availability",
                suffixIcon: Icon(
                  PhosphorIcons.caretDown,
                  color: AppColors.primary,
                ),
              ),
              const Gap(50),
              Button(
                "Confirm Details",
                onTap: () =>
                    context.push(const JobApplicationDocumentUploadPage()),
              ),
              const Gap(50)
            ],
          )),
        ),
      ),
    );
  }
}
