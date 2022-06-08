import 'package:flutter/widgets.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';

import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';

class CategoryItem {
  final String title;
  final String icon;
  CategoryItem({
    required this.title,
    this.icon = "",
  });
}

class CategorySection extends StatelessWidget {
  final String? title;
  final List<CategoryItem> categories;
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
              .map((category) => Container(
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
                        if (category.icon.isNotEmpty) ...[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.palette[300],
                            ),
                            child: ImageIcon(AssetImage(category.icon.pngIcon)),
                          ),
                          Gap.sm,
                        ],
                        Text(
                          category.title,
                          style: context.textTheme.bodyMedium.size(12),
                        )
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}

List<CategoryItem> categoryItems() => [
      CategoryItem(title: "Education", icon: "book"),
      CategoryItem(title: "Growth", icon: "growth"),
      CategoryItem(title: "Health", icon: "med"),
      CategoryItem(title: "Investment", icon: "growth"),
      CategoryItem(title: "Motivation", icon: "motivation"),
      CategoryItem(title: "Science", icon: "science"),
    ];

List<CategoryItem> categoryItemsNoIcons() => [
      CategoryItem(title: "Career", icon: ""),
      CategoryItem(title: "Black Woman", icon: ""),
      CategoryItem(title: "Growth", icon: ""),
      CategoryItem(title: "Investment", icon: ""),
      CategoryItem(title: "Cryptocurrency", icon: ""),
    ];

List<CategoryItem> jobsCategoryItemsNoIcons() => [
      CategoryItem(title: "HR", icon: ""),
      CategoryItem(title: "Accountant", icon: ""),
      CategoryItem(title: "Manager", icon: ""),
      CategoryItem(title: "Admin asst", icon: ""),
      CategoryItem(title: "Secretary", icon: ""),
      CategoryItem(title: "Business Admin", icon: ""),
    ];
