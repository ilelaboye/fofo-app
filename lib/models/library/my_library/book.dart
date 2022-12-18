import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'author.dart';

@immutable
class Book {
  final String? id;
  final String? name;
  final String? price;
  final int? ratings;
  final String? store;
  final String? bookImage;
  final String? description;
  final Author? author;
  final String? bookCategoryId;
  // BookCategory? bookCategoryId;

  Book(
      {this.id,
      this.name,
      this.author,
      this.price,
      this.ratings,
      this.store,
      this.bookImage,
      this.description,
      this.bookCategoryId});

  @override
  String toString() {
    return 'Book( id: $id, name: $name, author: $author, price: $price, ratings: $ratings, store: $store, bookImage: $bookImage,description:$description, bookCategoryId: $bookCategoryId)';
  }

  factory Book.fromMap(Map<String, dynamic> data) => Book(
      id: data['id'] as String?,
      name: data['name'] as String?,
      price: data['price'] as String?,
      ratings: data['ratings'] as int?,
      store: data['store'] as String?,
      bookImage: data['bookImage'] as String?,
      description:
          data.containsKey('description') ? data['description'] as String? : "",
      author: data['author'] == null
          ? null
          : Author.fromMap(data['author'] as Map<String, dynamic>),
      bookCategoryId:
          data['bookCategoryId'] == null ? null : data['bookCategoryId']);
  // : BookCategory.fromMap(
  //     data['bookCategoryId'] as Map<String, dynamic>));

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'ratings': ratings,
        'store': store,
        'bookImage': bookImage,
        'author': author,
        'bookCategoryId': bookCategoryId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Book].
  factory Book.fromJson(String data) {
    return Book.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Book] to a JSON string.
  String toJson() => json.encode(toMap());

  Book copyWith({
    String? id,
    String? name,
    String? price,
    int? ratings,
    String? store,
    String? bookImage,
    Author? author,
    // BookCategory? bookCategoryId,
    String? bookCategoryId,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      ratings: ratings ?? this.ratings,
      store: store ?? this.store,
      bookImage: bookImage ?? this.bookImage,
      author: author ?? this.author,
      bookCategoryId: bookCategoryId ?? this.bookCategoryId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Book) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      author.hashCode ^
      price.hashCode ^
      ratings.hashCode ^
      store.hashCode ^
      bookImage.hashCode ^
      author.hashCode ^
      bookCategoryId.hashCode;
}
