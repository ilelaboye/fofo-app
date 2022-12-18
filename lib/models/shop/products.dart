import 'dart:convert';

import 'package:flutter/material.dart';

import './category.dart';
import './product.dart';

@immutable
class Products {
  final List<Category>? categories;
  final List<Product>? products;

  const Products({
    this.categories,
    this.products,
  });

  @override
  String toString() {
    return 'Products(categories: $categories, products: $products, )';
  }

  factory Products.fromMap(Map<String, dynamic> data) => Products(
        categories: (data['categories'] as List<dynamic>)
            .map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        products: (data['products']['docs'] as List<dynamic>)
            .map((e) => Product.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Products].
  factory Products.fromJson(String data) {
    return Products.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  int get hashCode => categories.hashCode ^ products.hashCode;
}
