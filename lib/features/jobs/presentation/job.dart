import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/features/jobs/presentation/job_application_form.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class JobPage extends StatelessWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Job Details"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocalImage("job".png, height: 120),
                Gap.sm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin Assistant",
                        style: context.textTheme.bodyMedium.size(16).bold,
                      ),
                      Gap.xs,
                      Text(
                        "Zetti Compliance Ltd",
                        style: context.textTheme.bodyMedium.size(14),
                      ),
                      Gap.xs,
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: "New York, USA • ",
                            style: context.textTheme.bodyMedium
                                .size(12)
                                .changeColor(AppColors.palette[700]!),
                          ),
                          const TextSpan(
                            text: "Full time",
                          ),
                        ]),
                        style: context.textTheme.bodyMedium.size(12),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Gap.md,
            const SectionHeader("Description"),
            Gap.sm,
            Text(
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words whichdon't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't any thing embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet to repeat predefined chunks as necessary, making this the  first true generator on the Internet. It uses a dictionary of  over 200 Latin words, combined with a handful of model  sentence structures, to generate Lorem Ipsum which looks  reasonable... show less",
              style: context.textTheme.caption.size(13).copyWith(height: 1.8),
            ),
            Gap.md,
            const SectionHeader("Position Responsibilities"),
            Gap.sm,
            Text(
              _responsibilitisText,
              style: context.textTheme.caption.size(13).copyWith(height: 1.8),
            ),
            Gap.md,
            const SectionHeader("Minimum Qualifications & Skills"),
            Gap.sm,
            Text(
              _skillsText,
              style: context.textTheme.caption.size(13).copyWith(height: 1.8),
            ),
            Gap.md,
            Row(
              children: [
                const Icon(
                  PhosphorIcons.flagBanner,
                  size: 15,
                ),
                Gap.xs,
                Text(
                  "Report this post",
                  style: context.textTheme.caption.size(12),
                )
              ],
            ),
            Gap.lg,
            Button(
              "Apply For This Job",
              onTap: () => context.push(const JobApplicationFormPage()),
            ),
            const Gap(50)
          ],
        ),
      )),
    );
  }
}

const _responsibilitisText = '''
Provide first/second level contact and problem resolution for customer issues.
Work with Third Party Vendors to remediate complex AV issues as needed.
Provide timely communication on issue status and resolution.
Maintain ticket updates for all reported incidents.
Install, upgrade, support and troubleshoot XP, Windows 7, Windows 8.1, Windows 10 and Microsoft Office 2010, Cisco Jabber, another authorized desktop application.
Should have basic knowledge of Mac operating system, to support Apple pc users.
''';

const _skillsText = '''
Bachelor’s Degree or equivalent in Computer Science or related field.
CompTIA A+, Microsoft Certified Professional (MCP) or better.
Minimum of 18 months years of IT experience.
''';
