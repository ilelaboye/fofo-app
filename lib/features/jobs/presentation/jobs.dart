import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/jobs/presentation/job.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
// import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../service/job/job.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  late final Map jobs;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getJobs();
  }

  getJobs() async {
    EasyLoading.show(status: 'loading...');
    jobs =
        await Provider.of<JobProvider>(context, listen: false).getJobs(context);
    print('print jobs');
    print(jobs);
    EasyLoading.dismiss();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Container();
    } else {
      return Scaffold(
        appBar: const Appbar(title: "Opportunities"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextInputField(
                        hintText: "Job title, company",
                        prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                      ),
                    ),
                    Gap.md,
                    const Icon(PhosphorIcons.funnel)
                  ],
                ),
                Gap.lg,
                CategorySection(
                    categories: jobs['jobCategories'], seeAll: false),
                Gap.lg,
                const SectionHeader("Recommended", seeAll: false),
                Gap.md,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: Insets.xs + 2),
                    child: JobItem(job: jobs['recommended']['docs'][index]),
                  ),
                  itemCount: jobs['recommended']['docs'].length,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class JobItem extends StatelessWidget {
  final Map job;
  const JobItem({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: AppColors.palette[200]!,
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(AppColors.error,
                  radius: 18,
                  data: CircleAvatar(
                      backgroundColor: Colors.red,
                      backgroundImage: job['authorImages'] == [] ||
                              job['authorImages'][0]['secure_url'] == null
                          ? AssetImage("user".png) as ImageProvider
                          : NetworkImage(
                              job['authorImages'][0]['secure_url']))),
              Gap.sm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['jobField'],
                      style: context.textTheme.bodyMedium.size(14).bold,
                    ),
                    Gap.xs,
                    Text(
                      job['company_name'],
                      style: context.textTheme.bodyMedium.size(13),
                    ),
                    Gap.xs,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "New York, USA • ",
                          style: context.textTheme.bodyMedium
                              .size(10)
                              .changeColor(AppColors.palette[700]!),
                        ),
                        TextSpan(
                          text: job['jobType'],
                        ),
                      ]),
                      style: context.textTheme.bodyMedium.size(10),
                    )
                  ],
                ),
              ),
              const Icon(PhosphorIcons.dotsThreeVertical)
            ],
          ).onTap(() => context.push(JobPage(job: job))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.md),
            // Html(data: job['description'])
            child: Html(
              data: job['description'].length < 100
                  ? job['description']
                  : job['description'].substring(0, 100),
              // style: context.textTheme.caption.size(13),
            ),
          ).onTap(() => context.push(JobPage(job: job))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    PhosphorIcons.paperPlaneRightLight,
                    color: AppColors.palette[600],
                    size: 15,
                  ),
                  Gap.xs,
                  Text(
                    "Apply",
                    style: context.textTheme.bodyMedium.size(12).bold,
                  ).onTap(() => _launchURL(context, job['link']))
                ],
              ),
              Row(
                children: [
                  Icon(
                    PhosphorIcons.clock,
                    color: AppColors.palette[700],
                    size: 15,
                  ),
                  Gap.xs,
                  Text(
                    job['createdAt'].toString().getDateDifference(),
                    style: context.textTheme.caption.size(12),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Map category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.smBorder,
          color: AppColors.palette[100],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Insets.xs,
          horizontal: Insets.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category['description'],
              style: context.textTheme.bodyMedium.size(12),
            )
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String? title;
  final List categories;
  final bool seeAll, showTitle;

  const CategorySection(
      {required this.categories,
      this.title,
      this.seeAll = false,
      this.showTitle = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          SectionHeader(title ?? "Categories", seeAll: seeAll),
          Gap.sm,
        ],
        Wrap(
          spacing: Insets.md,
          runSpacing: Insets.sm,
          children: categories
              .map((category) => CategoryItem(category: category))
              .toList(),
        )
      ],
    );
  }
}

Future<void> _launchURL(BuildContext context, link) async {
  try {
    await launch(
      link,
      customTabsOption: CustomTabsOption(
        toolbarColor: AppColors.primary,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: CustomTabsSystemAnimation.slideIn(),
        extraCustomTabs: const <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
      safariVCOption: SafariViewControllerOption(
        preferredBarTintColor: AppColors.primary,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}
