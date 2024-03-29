import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/button.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/subscription/presentation/membership_plan.dart';

class MembershipPlanCard extends StatelessWidget {
  // replace with membershipEntity
  final Color? color, textColor;
  final String membershipId;
  final String membershipType;
  final double fee;
  final double pricePerYear;
  final double pricePerMonth;
  final String title, desc, benefit;
  final bool isPopular;
  final List<dynamic> perks;
  final Map user;
  const MembershipPlanCard(
      {required this.membershipId,
      required this.membershipType,
      this.color,
      this.textColor,
      this.fee = 0,
      this.pricePerYear = 0,
      this.pricePerMonth = 0,
      this.desc = "",
      this.benefit = "",
      this.title = "Access",
      this.isPopular = false,
      this.perks = const [],
      required this.user,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(Insets.md),
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.md + 4,
            vertical: Insets.lg,
          ),
          decoration: BoxDecoration(
            borderRadius: Corners.mdBorder,
            border: Border.all(color: const Color(0xFF2A3147), width: 0.7),
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (fee != 0)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$$fee",
                      style: context.textTheme.headlineLarge!
                          .changeColor(AppColors.palette[500]!),
                    ),
                    Gap.sm,
                    Text(
                      "/ Month",
                      style: context.textTheme.bodyMedium!
                          .changeColor(AppColors.palette[500]!),
                    )
                  ],
                )
              else
                Text(
                  "Free",
                  style: context.textTheme.headlineLarge!
                      .changeColor(const Color(0xFF2A3147))
                      .bold,
                ),
              Gap.sm,
              Text(
                title,
                style: context.textTheme.headlineMedium!
                    .changeColor(textColor ?? Colors.white)
                    .bold,
              ),
              Gap.md,
              SizedBox(
                width: context.width / 2 + Insets.lg,
                child: Text(
                  desc,
                  style: context.textTheme.bodyMedium!
                      .changeColor(textColor ?? AppColors.palette[500]!),
                ),
              ),
              Gap.md,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: perks.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: textColor ?? AppColors.palette[500]!,
                      ),
                      Gap.sm,
                      Expanded(
                        child: Text(
                          perks[index],
                          style: context.textTheme.bodyMedium!
                              .changeColor(textColor ?? AppColors.palette[500]!)
                              .size(13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: const Color(0xFF2A3147)),
                  color: color,
                ),
                child: Button(
                  "Learn More",
                  onTap: () => context.push(MembershipPlanPage(
                    perks,
                    membershipId: membershipId,
                    membershipType: membershipType,
                    fee: fee,
                    title: title,
                    desc: desc,
                    benefit: benefit,
                    user: user,
                    pricePerYear: pricePerYear,
                    pricePerMonth: pricePerMonth,
                  )),
                  color: color == AppColors.palette[100] ? color : Colors.white,
                  textColor: AppColors.palette[900],
                ),
              )
            ],
          ),
        ),
        if (isPopular)
          Positioned(
              top: Insets.md / 2 - 4,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                    color: Color(0xffFFBE3E), borderRadius: Corners.lgBorder),
                child: Text(
                  "POPULAR",
                  style:
                      context.textTheme.bodyMedium!.changeColor(Colors.white),
                ),
              ))
      ],
    );
  }
}
