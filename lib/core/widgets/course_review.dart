import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/models/course/review.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(0.75),
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
                        child: index < review.rating
                            ? Icon(
                                PhosphorIcons.starFill,
                                size: 14,
                                color: Colors.green,
                              )
                            : Icon(
                                PhosphorIcons.star,
                                size: 14,
                                color: AppColors.primary,
                              ),
                      ),
                    ),
                  ),
                  Gap.sm,
                  Text(
                    review.reviewdBy!.fullname,
                    style: context.textTheme.bodySmall
                        .changeColor(AppColors.primary),
                  )
                ],
              ),
              Text(
                review.createdAt.toString().getDateDifference(),
                style: context.textTheme.caption
                    .changeColor(AppColors.palette[600]!),
              )
            ],
          ),
          Gap.md,
          Flexible(
            child: Text(
              review.comment.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: context.textTheme.caption
                  .changeColor(AppColors.palette[700]!)
                  .copyWith(height: 1.4),
            ),
          )
        ],
      ),
    );
  }
}

class CourseReviewList extends StatelessWidget {
  final List<Review> reviews;
  const CourseReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? Insets.lg : Insets.sm,
            // use index == reviews.length -1
            right: index == reviews.length - 1 ? Insets.lg : 0,
          ),
          child: ReviewCard(review: reviews[index]),
        ),
        itemCount: reviews.length,
      ),
    );
  }
}

class ReviewAllList extends StatelessWidget {
  const ReviewAllList({Key? key}) : super(key: key);

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
