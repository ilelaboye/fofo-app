import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/service/library/my_library_provider.dart';
import 'package:provider/provider.dart';

import '../../models/library/my_library/category.dart';

// class CategoryItem {
//   final String title;
//   final String icon;
//   CategoryItem({
//     required this.title,
//     this.icon = "",
//   });
// }

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LibraryProvider libraryProvider = Provider.of<LibraryProvider>(context);
    return GestureDetector(
      // onTap: ()async{
      //   await libraryProvider.fetchCategoryById(context, category.id.toString());
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const CategoryView()),
      //     (route) => false);
      // },
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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.palette[300],
              ),
              child: category.iconName == null
                  ? const Offstage()
                  : ImageIcon(NetworkImage(category.iconName)),
            ),
            Gap.sm,
            Text(
              category.title ?? '',
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
  final List<Category> categories;
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

List<CategoryItem> categoryItems() => [
      CategoryItem(category: Category(title: "School")),
      // CategoryItem(title: "Growth", icon: "growth"),
      // CategoryItem(title: "Health", icon: "med"),
      // CategoryItem(title: "Investment", icon: "growth"),
      // CategoryItem(title: "Motivation", icon: "motivation"),
      // CategoryItem(title: "Science", icon: "science"),
    ];

List<Category> categoryItemsNoIcons() => [
      Category(title: "Career", iconName: null),
      // CategoryItem(title: "Black Woman", icon: ""),
      // CategoryItem(title: "Growth", icon: ""),
      // CategoryItem(title: "Investment", icon: ""),
      // CategoryItem(title: "Cryptocurrency", icon: ""),
    ];

List<Category> jobsCategoryItemsNoIcons() => [
      // CategoryItem(title: "HR", icon: ""),
      // CategoryItem(title: "Accountant", icon: ""),
      // CategoryItem(title: "Manager", icon: ""),
      // CategoryItem(title: "Admin asst", icon: ""),
      // CategoryItem(title: "Secretary", icon: ""),
      // CategoryItem(title: "Business Admin", icon: ""),
    ];
