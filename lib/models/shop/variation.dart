import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class Variation {
  final String? id;
  final String? size;
  final int? price;
  final int? qty;
  final String? color;

  const Variation({
    this.id,
    this.size,
    this.price,
    this.qty,
    this.color,
  });

  @override
  String toString() {
    return 'Variation(id: $id, size: $size, price: $price, qty: $qty, color: $color, )';
  }

  factory Variation.fromMap(Map<String, dynamic> data) => Variation(
        id: data['id'] as String?,
        size: data['size'] as String?,
        price: data['price'] as int?,
        qty: data['qty'] as int?,
        color: data['color'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'size': size,
        'price': price,
        'qty': qty,
        'color': color,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Variation].
  factory Variation.fromJson(String data) {
    return Variation.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Variation] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Variation) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      size.hashCode ^
      price.hashCode ^
      qty.hashCode ^
      color.hashCode;
}
