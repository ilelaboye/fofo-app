import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'author.dart';
import 'book_category.dart';

@immutable
class Book {
  final String? id;
  final String? title;
  final String? author;
  final String? price;
  final String? ratings;
  final String? store;
  final String? bookImage;
  Author? createdBy;
  BookCategory? bookCategoryId;

  Book(
      {this.id,
      this.title,
      this.author,
      this.price,
      this.ratings,
      this.store,
      this.bookImage,
      this.createdBy,
      this.bookCategoryId});

  @override
  String toString() {
    return 'Book( id: $id, title: $title, author: $author, price: $price, ratings: $ratings, store: $store, bookImage: $bookImage,createdBy:$createdBy, bookCategoryId: $bookCategoryId)';
  }

  factory Book.fromMap(Map<String, dynamic> data) => Book(
      id: data['id'] as String,
      title: data['title'] as String,
      author: data['author'] as String,
      price: data['price'] as String,
      ratings: data['ratings'] as String,
      store: data['store'] as String,
      bookImage: data['bookImage'] as String,
      createdBy: data['createdBy'] == null
          ? null
          : Author.fromMap(data['createdBy'] as Map<String, dynamic>),
      bookCategoryId: data['bookCategoryId'] == null
          ? null
          : BookCategory.fromMap(
              data['bookCategoryId'] as Map<String, dynamic>));

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'price': price,
        'ratings': ratings,
        'store': store,
        'bookImage': bookImage,
        'createdBy': createdBy,
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
    String? title,
    String? author,
    String? price,
    String? ratings,
    String? store,
    String? bookImage,
    Author? createdBy,
    BookCategory? bookCategoryId,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      ratings: ratings ?? this.ratings,
      store: store ?? this.store,
      bookImage: bookImage ?? this.bookImage,
      createdBy: createdBy ?? this.createdBy,
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
      title.hashCode ^
      author.hashCode ^
      price.hashCode ^
      ratings.hashCode ^
      store.hashCode ^
      bookImage.hashCode ^
      createdBy.hashCode ^
      bookCategoryId.hashCode;
}
