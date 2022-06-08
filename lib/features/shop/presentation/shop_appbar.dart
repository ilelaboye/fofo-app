import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/features/shop/presentation/bag.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShopAppbar extends Appbar {
  const ShopAppbar({required String title, Key? key})
      : super(key: key, title: title);

  @override
  Widget build(BuildContext context) {
    return Appbar(
      title: title,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: Insets.sm),
          child: IconButton(
              onPressed: () => context.push(const BagPage()),
              icon: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(Insets.xs),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.palette[100],
                    ),
                    child: Icon(
                      PhosphorIcons.shoppingBagFill,
                      color: AppColors.palette[700],
                      size: 20,
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.error,
                        ),
                        child: Text(
                          "4",
                          style: context.textTheme.caption
                              .changeColor(Colors.white),
                        ),
                      ))
                ],
              )),
        )
      ],
    );
  }
}
