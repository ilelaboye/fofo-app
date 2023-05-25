import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReviewCard extends StatelessWidget {
  Map review = {};
  ReviewCard({required this.review, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: context.getWidth(0.75),
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: Colors.red,
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Icon(
                          index < review['rating']
                              ? PhosphorIcons.starFill
                              : PhosphorIcons.star,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Gap.sm,
                  Text(
                    review['name'],
                    style: context.textTheme.bodySmall
                        .changeColor(AppColors.primary),
                  )
                ],
              ),
              Text(
                review['createdAt'].toString().getDateDifference(),
                style: context.textTheme.caption
                    .changeColor(AppColors.palette[600]!),
              )
            ],
          ),
          Gap.md,
          Text(
            review['comment'],
            style: context.textTheme.caption
                .changeColor(AppColors.palette[700]!)
                .copyWith(height: 1.4),
          )
        ],
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  List reviews = [];
  ReviewList({required this.reviews, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviews.length > 0
        ? SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? Insets.lg : Insets.sm,
                  // use index == reviews.length -1
                  right: index == 2 ? Insets.lg : 0,
                ),
                child: ReviewCard(review: reviews[index]),
              ),
              itemCount: reviews.length,
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: Insets.lg),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xff0f1dcb9),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: const Text(
              'No review',
              style: TextStyle(fontSize: 14),
            ),
          );
  }
}

class ReviewAllList extends StatelessWidget {
  List reviews = [];
  ReviewAllList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(height: Insets.lg),
      itemBuilder: (context, index) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Icon(
                          PhosphorIcons.starFill,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Gap.sm,
                  Text(
                    "Lovely bag.",
                    style: context.textTheme.bodyMedium
                        .size(17)
                        .changeColor(AppColors.primary),
                  )
                ],
              ),
              Text(
                "7 days ago",
                style: context.textTheme.caption
                    .changeColor(AppColors.palette[600]!),
              )
            ],
          ),
          Gap.md,
          Text(
            "Ut enim ad minima veniam, quis nostrum exercitatio nem ullam corporis suscipit labori osam, nisi ut aliq uid ex ea commodi consu  sequatur? Quis autem vel eum iure repreh.",
            style: context.textTheme.caption
                .changeColor(AppColors.palette[700]!)
                .size(13)
                .copyWith(height: 1.4),
          )
        ],
      ),
      itemCount: 7,
    );
  }
}
