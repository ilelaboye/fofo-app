import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool hasLeading;
  const Appbar(
      {this.title = "",
      this.hasLeading = true,
      this.titleWidget,
      this.leading,
      this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasLeading
          ? Padding(
              padding:
                  const EdgeInsets.only(bottom: Insets.sm, left: Insets.md),
              child: leading ?? const CustomBackButton(),
            )
          : null,
      title: titleWidget ??
          Text(
            title,
            style: context.textTheme.bodyMedium.size(15).bold,
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.palette[200],
      ),
      child: Icon(
        PhosphorIcons.caretLeftBold,
        color: AppColors.primary,
      ),
    ).onTap(
      () => context.pop(),
    );
  }
}
