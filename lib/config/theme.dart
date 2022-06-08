import 'package:flutter/material.dart';
import 'package:fofo_app/config/constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get _baseTheme => ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: AppColors.palette,
        scaffoldBackgroundColor: AppColors.scaffold,
        fontFamily: Fonts.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: Corners.smBorder,
                side: BorderSide(
                  color: AppColors.primary,
                )),
            primary: AppColors.primary,
            onPrimary: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.scaffold,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: IconThemeData(
          color: AppColors.dark,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      );

  static ThemeData get defaultTheme =>
      _baseTheme.copyWith(brightness: Brightness.light);
}

class Fonts {
  static const primary = "Trap";
}

class Insets {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 32;
}

class Corners {
  static const Radius xsRadius = Radius.circular(Insets.xs);
  static const BorderRadius xsBorder = BorderRadius.all(xsRadius);

  static const Radius smRadius = Radius.circular(Insets.sm);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  static const Radius mdRadius = Radius.circular(Insets.md);
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);

  static const Radius lgRadius = Radius.circular(Insets.lg);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);

  static const Radius xlRadius = Radius.circular(50);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
}

class FontSizes {
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s48 = 48;
}

class IconSizes {
  static const double sm = 18;
  static const double md = 24;
  static const double lg = 32;
}
