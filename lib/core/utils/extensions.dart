import 'package:flutter/material.dart';
import 'package:fofo_app/core/utils/router.dart';

extension StringExtension on String {
  String get png => "assets/images/$this.png";
  String get pngIcon => "assets/icons/$this.png";
  String get jpeg => "assets/images/$this.jpeg";
  String get jpg => "assets/images/$this.jpg";

  String pluralize(int len) {
    if (isEmpty) return "";
    if (len == 1) return this;
    if (this[length - 1] == "y") return "${substring(0, length - 1)}ies";
    return "${this}s";
  }

  String titleCaseSingle() {
    if (isEmpty) return "";
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension IntExtension on int {
  Duration get seconds => Duration(seconds: this);
  Duration get millisecs => Duration(milliseconds: this);
}

extension ContextExtension on BuildContext {
  double getHeight([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> push<T>(Widget page) =>
      Navigator.push<T>(this, PageRouter.fadeThrough(() => page));

  Future<T?> pushOff<T>(Widget page) => Navigator.pushAndRemoveUntil<T>(
      this, PageRouter.fadeThrough(() => page), (_) => false);

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}

extension TextStyleExtension on TextStyle? {
  TextStyle get bold => this!.copyWith(fontWeight: FontWeight.w700);
  TextStyle size(double size) => this!.copyWith(fontSize: size);
  TextStyle changeColor(Color? color) => this!.copyWith(color: color);
}

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
