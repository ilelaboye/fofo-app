import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/core/utils/extensions.dart';

const double kLeftPadding = 20;
const int kShowCount = 8;
const double kAvatarRadius = 25;

class AvatarGroup extends StatelessWidget {
  // replace colors with avatar images
  final List<Color> colors;
  final double groupRadius, leftPadding;
  final int showCount;
  final Text? trailing;
  final TextStyle? textStyle;
  const AvatarGroup(this.colors,
      {this.groupRadius = kAvatarRadius,
      this.showCount = kShowCount,
      this.leftPadding = kLeftPadding,
      this.trailing,
      this.textStyle,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final avatarGroup = List.generate(
      showCount < 9 ? showCount : 8,
      (index) => Positioned(
        left: index * leftPadding,
        child: Avatar(
          colors[index],
          radius: groupRadius,
        ),
      ),
    );

    if (showCount > 8) {
      final hiddenCount = showCount - 8;
      avatarGroup.add(Positioned(
        left: leftPadding * (showCount),
        child: Avatar(
          AppColors.palette[300]!,
          radius: groupRadius,
          data: Center(
            child: Text(
              hiddenCount.toString(),
              style: textStyle ??
                  context.textTheme.bodyMedium
                      .changeColor(AppColors.primary)
                      .bold,
            ),
          ),
        ),
      ));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 50,
          width: context.width,
        ),
        ...avatarGroup,
        if (colors.length > showCount) ...[
          Positioned(
            left: leftPadding * (showCount + 1) + (groupRadius * 2),
            child: trailing ??
                Text(
                  "Members",
                  style: context.textTheme.bodyMedium!.size(14).bold,
                ),
          )
        ]
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final Color color;
  final Widget? data; // can be imageUrl or text
  final double radius;
  const Avatar(this.color, {this.radius = kAvatarRadius, this.data, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1.7,
          ),
        ),
        child: data,
      ),
    );
  }
}
