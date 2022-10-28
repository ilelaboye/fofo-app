import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class TopAuthor {
  final String? id;
  final String? author;
  final String? price;
  final String? title;
  final String? bookImage;
  final int? totalBooksWritten;

  const TopAuthor(
      {this.id,
      this.author,
      this.title,
      this.price,
      this.bookImage,
      this.totalBooksWritten});

  @override
  String toString() {
    return 'TopAuthor(id: $id, author: $author, title: $title,price:$price,bookImage:$bookImage, totalBooksWritten: $totalBooksWritten)';
  }

  factory TopAuthor.fromMap(Map<String, dynamic> data) => TopAuthor(
        id: data['id'] as String?,
        author: data['author'] as String?,
        price: data['price'] as String?,
        title: data['title'] as String?,
        bookImage: data['bookImage'] as String?,
        totalBooksWritten: data['totalBooksWritten'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'author': author,
        'price': price,
        'title': title,
        'bookImage': bookImage,
        'totalBooksWritten': totalBooksWritten,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopAuthor].
  factory TopAuthor.fromJson(String data) {
    return TopAuthor.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopAuthor] to a JSON string.
  String toJson() => json.encode(toMap());

  TopAuthor copyWith({
    String? id,
    String? author,
    String? title,
    String? price,
    String? bookImage,
    int? totalBooksWritten,
  }) {
    return TopAuthor(
      id: id ?? this.id,
      author: author ?? this.author,
      title: title ?? this.title,
      price: price ?? this.price,
      bookImage: bookImage ?? this.bookImage,
      totalBooksWritten: totalBooksWritten ?? this.totalBooksWritten,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TopAuthor) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      author.hashCode ^
      title.hashCode ^
      price.hashCode ^
      bookImage.hashCode ^
      totalBooksWritten.hashCode;
}
