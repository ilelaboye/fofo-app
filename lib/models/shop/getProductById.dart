import 'dart:convert';

import 'package:flutter/material.dart';

import 'product.dart';

@immutable
class GetProductById {
  final Product product;
  final List<Map>? reviews;

  const GetProductById({
    required this.product,
    this.reviews,
  });

  @override
  String toString() {
    return 'GetProductById(product: $product, reviews:$reviews)';
  }

  factory GetProductById.fromMap(Map<String, dynamic> data) => GetProductById(
        product: Product.fromMap(data['product'] as Map<String, dynamic>),
        reviews: (data['reviews']['docs'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetProductById].
  factory GetProductById.fromJson(String data) {
    return GetProductById.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}
