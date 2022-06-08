import 'package:flutter/material.dart';
import 'package:fofo_app/core/widgets/image.dart';
import 'package:fofo_app/features/auth/presentation/signup.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: items
            .map((item) => Stack(
                  children: [
                    SizedBox(
                      child: LocalImage("onboarding".jpg),
                    ),
                    Positioned(
                      top: Insets.lg + Insets.lg,
                      right: Insets.lg,
                      child: Text(
                        'Skip',
                        style: context.textTheme.bodyLarge!
                            .changeColor(Colors.white)
                            .size(18),
                      ).onTap(() => context.push(const SignupPage())),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: context.getHeight(0.42),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Corners.lgRadius,
                            topRight: Corners.lgRadius,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap.lg,
                            Text(
                              item.title,
                              style: context.textTheme.headlineMedium!.bold
                                  .size(24)
                                  .changeColor(AppColors.primary),
                            ),
                            Gap.sm,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Insets.lg),
                              child: Text(
                                item.desc,
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyMedium!
                                    .size(12)
                                    .changeColor(AppColors.palette[700]!)
                                    .copyWith(height: 1.8),
                              ),
                            ),
                            Gap.lg,
                            Button(
                              "Get Started",
                              width: context.width / 2,
                              onTap: () => context.push(const SignupPage()),
                            ),
                            Gap.md,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Next'),
                                Gap.sm,
                                Icon(PhosphorIcons.arrowRight)
                              ],
                            ).onTap(
                              () => _controller.nextPage(
                                duration: 200.millisecs,
                                curve: Curves.ease,
                              ),
                            ),
                            Gap.lg,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(
                                  items.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Insets.xs,
                                    ),
                                    child: PageIndicator(
                                      isCurrent: index == items.indexOf(item),
                                    ),
                                  ),
                                ).toList()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final bool isCurrent;
  const PageIndicator({this.isCurrent = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 2.seconds,
      height: 4,
      width: isCurrent ? 50 : 25,
      decoration: BoxDecoration(
        borderRadius: Corners.smBorder,
        color: isCurrent ? AppColors.primary : AppColors.palette[300],
      ),
    );
  }
}

class Item {
  final String title;
  final String desc;
  // addd imgUrl
  const Item({
    required this.title,
    required this.desc,
  });
}

const items = [
  Item(
    title: 'Build It',
    desc:
        'Starting a career can sometimes be daunting. We’ll help you clarify your purpose, overcome impostor syndrome, boost your confidence, and accelerate success.',
  ),
  Item(
    title: 'Expand It',
    desc:
        'As your career progresses, you need to stand out and leverage influence - we help you enjoy work, attract sponsors, make bold career moves, and harmonize work life.',
  ),
  Item(
    title: 'Sustain It',
    desc:
        'Whether stepping into a C-suite or board-level position, we help you live purposefully, in and out of the boardroom, building lasting influence and impact globally.',
  ),
];
