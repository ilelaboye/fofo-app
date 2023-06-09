import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/features/subscription/presentation/membership_plan_card.dart';
import 'package:fofo_app/service/auth_service/auth_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key, required this.user}) : super(key: key);
  final Map user;
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late PageController _controller;
  List membership = [];

  @override
  void initState() {
    super.initState();
    getMembership();
    _controller = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  void getMembership() async {
    EasyLoading.show(status: "Loading...");
    Map resp = await context.read<AuthProvider>().getMembership(context);
    membership = resp['data']['memberships'];
    EasyLoading.dismiss();
    print('kfkf');
    print(resp);
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
                style: context.textTheme.bodyLarge!
                    .changeColor(const Color(0xFF2A3147)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.md),
              child: Text(
                "Memberships",
                style: context.textTheme.headlineMedium!.bold
                    .size(24)
                    .changeColor(const Color(0xFF2A3147)),
              ),
            ),
            SizedBox(
              height: 600,
              child: PageView(controller: _controller, children: [
                ...membership.map((e) => MembershipPlanCard(
                    membershipId: e['membershipId'],
                    membershipType: e['membershipType'],
                    color: e['membershipType'] == 'Silver'
                        ? const Color(0xFFFFF5F5)
                        : AppColors.primary,
                    textColor: e['membershipType'] == 'Silver'
                        ? const Color(0xFF2A3147)
                        : Colors.white,
                    user: widget.user,
                    fee: e['pricePerMonth'].toDouble(),
                    pricePerYear: e['pricePerYear'].toDouble(),
                    pricePerMonth: e['pricePerMonth'].toDouble(),
                    isPopular: true,
                    title: e['membershipType'],
                    desc: e['description'],
                    benefit: e['benefits'],
                    perks: e['perks'])),
              ]
                  // [
                  //   MembershipPlanCard(
                  //       color: AppColors.primary,
                  //       textColor: Colors.white,
                  //       fee: 25,
                  //       isPopular: true,
                  //       title: "Gold Access",
                  //       desc:
                  //           "Take your Tfemme experience to the next level with exclusive features and front row access to growth spurring resources.",
                  //       benefit:
                  //           "Accelerate your growth with access to discounts on trainings and books. Network with thought leaders and high flyers in your industry.",
                  //       perks: const [
                  //         "All Access to the Silver Membership Level",
                  //         "Downloadable templates to feel more confident, empowered and organized.",
                  //         "Bonus training worth \$49 from co-founder Mofoluwaso Ilevbare",
                  //         "Digital Community Networking Forum & Groups",
                  //         "Monthly Goal Challenges (Upcoming)",
                  //         "Discount to Affliate Partner Services (Upcoming)"
                  //       ],
                  //       user: widget.user),
                  //   MembershipPlanCard(
                  //       color: const Color(0xFFFFF5F5),
                  //       textColor: const Color(0xFF2A3147),
                  //       title: "Silver Access",
                  //       desc:
                  //           "Become a member of the TFemme community. Get insights to help you grow as a professional.",
                  //       benefit:
                  //           "Increase you productivity and get the tools you need to overcome self doubt and imposter syndrome. Manage your time and energy with actionable plans. Get access to free, industry relevant opportunities",
                  //       perks: const [
                  //         "Access to Blog Posts, Podcasts, Shop",
                  //         "FREE GIFT. Access to Downloadable Planner.",
                  //         "Create post, post comment, ask questions and interact with other.",
                  //       ],
                  //       user: widget.user),
                  // ],
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
      ),
    );
  }
}
