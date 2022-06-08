import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/auth/presentation/heading.dart';
import 'package:fofo_app/features/jobs/presentation/job_application_success.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class JobApplicationDocumentUploadPage extends StatefulWidget {
  const JobApplicationDocumentUploadPage({Key? key}) : super(key: key);

  @override
  _JobApplicationDocumentUploadPageState createState() =>
      _JobApplicationDocumentUploadPageState();
}

class _JobApplicationDocumentUploadPageState
    extends State<JobApplicationDocumentUploadPage> {
  bool hasAttachedResume = false;
  bool hasAttachedCover = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Application"),
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHeading(
              "Documents",
              "Upload required documents below, your cover letter and your resume",
            ),
            Gap.lg,
            Padding(
              padding: const EdgeInsets.only(bottom: Insets.sm),
              child: Text(
                "Resume",
                style: context.textTheme.bodyMedium!
                    .size(14)
                    .changeColor(AppColors.palette[900]!),
              ),
            ),
            AttachFileButton(
              "Attach resume",
              "docx, pdf, docs - not more than 1mb",
              hasAttached: hasAttachedResume,
              onAttach: () {
                setState(() {
                  hasAttachedResume = !hasAttachedResume;
                });
              },
            ),
            Gap.lg,
            Padding(
              padding: const EdgeInsets.only(bottom: Insets.sm),
              child: Text(
                "Cover letter",
                style: context.textTheme.bodyMedium!
                    .size(14)
                    .changeColor(AppColors.palette[900]!),
              ),
            ),
            AttachFileButton(
              "Attach cover letter",
              "docx, pdf, docs - not more than 100kb",
              hasAttached: hasAttachedCover,
              onAttach: () {
                setState(() {
                  hasAttachedCover = !hasAttachedCover;
                });
              },
            ),
            const Spacer(),
            Row(
              children: [
                SizedBox(
                  width: context.width / 4,
                  child: Button(
                    "Back",
                    onTap: () => context.pop(),
                    color: Colors.white,
                    textColor: AppColors.palette[900],
                  ),
                ),
                Gap.md,
                Expanded(
                  child: Button(
                    'Submit Application',
                    onTap: () {
                      context.push(const JobApplicationSuccessPage());
                    },
                  ),
                ),
              ],
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}

class AttachFileButton extends StatelessWidget {
  final String title, subtitle;
  final bool hasAttached;
  final Function? onAttach;
  const AttachFileButton(this.title, this.subtitle,
      {this.hasAttached = false, this.onAttach, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: Corners.xsRadius,
      padding: EdgeInsets.zero,
      borderType: BorderType.RRect,
      color: hasAttached ? const Color(0xff3B9B7B) : AppColors.primary,
      dashPattern: const [5, 4],
      child: SizedBox(
        width: context.width,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.lg,
            vertical: Insets.md,
          ),
          decoration: BoxDecoration(
            color:
                hasAttached ? const Color(0xffF3FBF9) : AppColors.palette[100],
            borderRadius: Corners.smBorder,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.md,
                  vertical: Insets.sm,
                ),
                decoration: BoxDecoration(
                  borderRadius: Corners.smBorder,
                  color:
                      hasAttached ? const Color(0xff3B9B7B) : AppColors.primary,
                ),
                child: hasAttached
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            PhosphorIcons.checkCircleFill,
                            color: Colors.white,
                          ),
                          Gap.sm,
                          Text(
                            "document_filename.pdf",
                            style: context.textTheme.caption
                                .changeColor(Colors.white),
                          )
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            PhosphorIcons.plusCircleFill,
                            color: Colors.white,
                          ),
                          Gap.sm,
                          Text(
                            title,
                            style: context.textTheme.caption
                                .changeColor(Colors.white),
                          )
                        ],
                      ),
              ).onTap(() => onAttach?.call()),
              if (!hasAttached) ...[
                Gap.sm,
                Text(
                  subtitle,
                  style: context.textTheme.caption,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
