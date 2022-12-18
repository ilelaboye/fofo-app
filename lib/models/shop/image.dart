import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class ProductImage {
  final String? id;
  final String? secure_url;

  const ProductImage({
    required this.id,
    required this.secure_url,
  });

  factory ProductImage.fromMap(Map<String, dynamic> data) => ProductImage(
      id: data['id'] as String, secure_url: data['secure_url'] as String);

  Map<String, dynamic> toMap() => {'id': id, 'secure_url': secure_url};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductImage].
  factory ProductImage.fromJson(String data) {
    return ProductImage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  int get hashCode => id.hashCode ^ secure_url.hashCode;
}
