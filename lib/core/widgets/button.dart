import 'package:flutter/material.dart';
import 'package:fofo_app/core/utils/extensions.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? radius;

  /// if child is not null, we want to use it instead of the label
  final Widget? child;
  const Button(this.label,
      {this.onTap,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.radius,
      this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height ?? 49,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            Text(
              label!,
              style: textColor != null
                  ? context.textTheme.button!.copyWith(color: textColor)
                  : null,
            ),
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  // Change your radius here
                  borderRadius: BorderRadius.circular(radius ?? 9),
                ),
              ),
            ),
      ),
    );
  }
}
