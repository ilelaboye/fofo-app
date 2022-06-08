import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';

class PriceBadge extends StatelessWidget {
  final bool free;
  const PriceBadge({this.free = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = free ? const Color(0xffE99F0C) : const Color(0xff3B9B7B);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: Corners.smBorder,
        border: Border.all(color: color),
        color: free ? const Color(0xffFFF9F0) : const Color(0xffF3FBF9),
      ),
      child: Text(
        free ? "free" : "exclusive",
        style: context.textTheme.caption.changeColor(color),
      ),
    );
  }
}
