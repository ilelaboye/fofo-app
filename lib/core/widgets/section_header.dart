import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget trailing;
  final bool seeAll;
  final Function? onClickSeeAll;

  const SectionHeader(this.title,
      {this.trailing = const SizedBox(),
      this.seeAll = false,
      this.onClickSeeAll,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium
              .changeColor(AppColors.primary)
              .size(18)
              .bold,
        ),
        // Add function callback for seeAll click
        if (seeAll)
          const SeeAll().onTap(() => onClickSeeAll?.call())
        else
          trailing,
      ],
    );
  }
}

class SeeAll extends StatelessWidget {
  const SeeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text("See All"),
        Gap.sm,
        Padding(
          padding: EdgeInsets.only(bottom: 2.5),
          child: Icon(
            PhosphorIcons.arrowRight,
            size: 18,
          ),
        )
      ],
    );
  }
}
