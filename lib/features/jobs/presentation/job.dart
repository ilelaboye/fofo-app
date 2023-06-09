import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:fofo_app/features/jobs/presentation/job_application_form.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/utils/luncher.dart';

class JobPage extends StatelessWidget {
  final Map job;

  JobPage({Key? key, required this.job}) : super(key: key);
  final luncher = Luncher();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Job Details"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LocalImage("job".png, height: 120),
                NetworkImg(
                  job['jobImages'][0]['secure_url'],
                  width: 80,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                Gap.sm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job['jobField'].toString().titleCaseSingle(),
                        style: context.textTheme.bodyMedium.size(16).bold,
                      ),
                      Gap.xs,
                      Text(
                        job['company_name'],
                        style: context.textTheme.bodyMedium.size(14),
                      ),
                      Gap.xs,
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: "${job['location']} • ",
                            style: context.textTheme.bodyMedium
                                .size(12)
                                .changeColor(AppColors.palette[700]!),
                          ),
                          TextSpan(
                            text: job['jobType'],
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
            Html(data: job['description']),
            // Text(
            //   job['description'],
            //   style: context.textTheme.caption.size(13).copyWith(height: 1.8),
            // ),
            Gap.md,
            // const SectionHeader("Position Responsibilities"),
            // Gap.sm,
            // Text(
            //   _responsibilitisText,
            //   style: context.textTheme.caption.size(13).copyWith(height: 1.8),
            // ),
            // Gap.md,
            // const SectionHeader("Minimum Qualifications & Skills"),
            // Gap.sm,
            // Text(
            //   _skillsText,
            //   style: context.textTheme.caption.size(13).copyWith(height: 1.8),
            // ),
            // Gap.md,
            // Row(
            //   children: [
            //     const Icon(
            //       PhosphorIcons.flagBanner,
            //       size: 15,
            //     ),
            //     Gap.xs,
            //     Text(
            //       "Report this post",
            //       style: context.textTheme.caption.size(12),
            //     )
            //   ],
            // ),
            // Gap.lg,
            Button(
              "Apply For This Job",
              onTap: () => luncher.launchURL(context, job['link']),
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
