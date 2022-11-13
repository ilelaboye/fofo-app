import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class TopAuthor {
  final String? id;
  final String? fullname;
  final String? price;
  final String? title;
  final String? image_url;
  final int? totalBooksWritten;

  const TopAuthor(
      {this.id,
      this.fullname,
      this.title,
      this.price,
      this.image_url,
      this.totalBooksWritten});

  @override
  String toString() {
    return 'TopAuthor(id: $id, fullname: $fullname, title: $title,price:$price,image_url:$image_url, totalBooksWritten: $totalBooksWritten)';
  }

  factory TopAuthor.fromMap(Map<String, dynamic> data) => TopAuthor(
        id: data['id'] as String?,
        fullname: data['fullname'] as String?,
        price: data['price'] as String?,
        title: data['title'] as String?,
        image_url: data['image_url'] as String?,
        totalBooksWritten: data['totalBooksWritten'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullname': fullname,
        'price': price,
        'title': title,
        'image_url': image_url,
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
    String? fullname,
    String? title,
    String? price,
    String? image_url,
    int? totalBooksWritten,
  }) {
    return TopAuthor(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      title: title ?? this.title,
      price: price ?? this.price,
      image_url: image_url ?? this.image_url,
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
      fullname.hashCode ^
      title.hashCode ^
      price.hashCode ^
      image_url.hashCode ^
      totalBooksWritten.hashCode;
}
