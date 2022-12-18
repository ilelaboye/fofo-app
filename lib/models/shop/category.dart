import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fofo_app/models/shop/product.dart';

@immutable
class Category {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final List<Product>? products;

  const Category(
      {required this.id,
      required this.name,
      this.description,
      this.createdAt,
      this.products,
      this.updatedAt});

  factory Category.fromMap(Map<String, dynamic> data) => Category(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String?,
      createdAt: data['createdAt'] as String?,
      updatedAt: data['updatedAt'] as String?,
      products: (data['products'] as List<dynamic>)
          .map((e) => Product.fromMap(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'products': products,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;
}
