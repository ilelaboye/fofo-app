import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/features/subscription/presentation/membership_plan_card.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Insets.lg - 8),
            child: IconButton(
              onPressed: () => context.pushOff(const AppScaffoldPage()),
              icon: Text(
                "Skip",
                style:
                    context.textTheme.bodyLarge!.changeColor(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.md),
            child: Text(
              "Memberships",
              style: context.textTheme.headlineMedium!.bold
                  .size(24)
                  .changeColor(AppColors.primary),
            ),
          ),
          SizedBox(
            height: 580,
            child: PageView(
              controller: _controller,
              children: [
                MembershipPlanCard(
                  color: AppColors.primary,
                  fee: 25,
                  isPopular: true,
                  title: "Gold Access",
                  desc:
                      "Take your Tfemme experience to the next level with exclusive features and front row access to growth spurring resources.",
                  benefit:
                      "Accelerate your growth with access to discounts on trainings and books. Network with thought leaders and high flyers in your industry.",
                  perks: const [
                    "Can access silver membership plus",
                    "Downloadable templates to feel more confident, empowered and organized.",
                    "Bonus training worth \$49 from co-founder Mofoluwaso Ilevbare",
                    "Digital Community Networking Forum & Groups",
                    "Monthly Goal Challenges (push notifications)",
                    "Discounts to Affiliate Partner Services"
                  ],
                ),
                MembershipPlanCard(
                  color: AppColors.palette[100],
                  textColor: AppColors.primary,
                  title: "Silver Access",
                  desc:
                      "Become a member of the TFemme community. Get insights to help you grow as a professional.",
                  benefit:
                      "Increase you productivity and get the tools you need to overcome self doubt and imposter syndrome. Manage your time and energy with actionable plans. Get access to free, industry relevant opportunities",
                  perks: const [
                    "Home page",
                    "Blog page, Podcast, YouTube, Shop, etc.",
                    "Daily Affirmations (push notifications).",
                    "Announcement Dashboard (push notification).",
                    "FREE GIFT: a Downloadable Planner.",
                    "Can create a post or ask a question (simple page)."
                  ],
                ),
              ],
            ),
          ),
          if (_controller.hasClients)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  2,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.xs,
                    ),
                    child: AnimatedContainer(
                      duration: 200.millisecs,
                      height: 4,
                      width: _controller.page!.round() == index ? 16 : 8,
                      decoration: BoxDecoration(
                        borderRadius: Corners.smBorder,
                        color: _controller.page!.round() == index
                            ? AppColors.primary
                            : AppColors.palette[300],
                      ),
                    ),
                  ),
                ).toList()
              ],
            )
        ],
      ),
    );
  }
}
