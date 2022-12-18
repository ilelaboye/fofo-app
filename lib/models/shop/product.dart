import 'package:flutter/material.dart';
import 'package:fofo_app/models/shop/image.dart';
import 'package:fofo_app/models/shop/variation.dart';

@immutable
class Product {
  final String id;
  final String name;
  final String? description;
  final int? stock;
  final List<Variation>? product_variation;
  final List<ProductImage>? product_images;
  final int? ratings;
  final int? numOfReviews;
  final String? createdAt;

  const Product(
      {required this.id,
      required this.name,
      this.description,
      this.stock,
      this.product_variation,
      this.product_images,
      this.ratings,
      this.numOfReviews,
      this.createdAt});

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, stock: $stock, ratings: $ratings, product_variation: $product_variation,product_images: $product_images,ratings: $ratings,numOfReviews: $numOfReviews,createdAt: $createdAt, )';
  }

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: data['id'] as String,
        name: data['name'] as String,
        description: data.containsKey('description')
            ? data['description'] as String?
            : null,
        stock: data.containsKey('stock') ? data['stock'] as int? : null,
        product_variation: data.containsKey('product_variation')
            ? (data['product_variation'] as List<dynamic>)
                .map((e) => Variation.fromMap(e as Map<String, dynamic>))
                .toList()
            : [],
        product_images: (data['product_images'] as List<dynamic>)
            .map((e) => ProductImage.fromMap(e as Map<String, dynamic>))
            .toList(),
        ratings: data.containsKey('ratings') ? data['ratings'] as int? : null,
        numOfReviews: data.containsKey('numOfReviews')
            ? data['numOfReviews'] as int?
            : null,
        createdAt:
            data.containsKey('createdAt') ? data['createdAt'] as String? : null,
      );

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      stock.hashCode ^
      product_variation.hashCode ^
      product_images.hashCode ^
      ratings.hashCode ^
      numOfReviews.hashCode ^
      createdAt.hashCode;
}
