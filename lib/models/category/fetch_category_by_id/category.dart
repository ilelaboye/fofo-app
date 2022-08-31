import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class Category {
  final List<dynamic>? books;
  final String? title;
  final dynamic iconName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  const Category({
    this.books,
    this.title,
    this.iconName,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  @override
  String toString() {
    return 'Category(books: $books, title: $title, iconName: $iconName, createdAt: $createdAt, updatedAt: $updatedAt, id: $id)';
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        books: data['books'] as List<dynamic>?,
        title: data['title'] as String?,
        iconName: data['iconName'] as dynamic,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        id: data['id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'books': books,
        'title': title,
        'iconName': iconName,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
  String toJson() => json.encode(toMap());

  Category copyWith({
    List<dynamic>? books,
    String? title,
    dynamic iconName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
  }) {
    return Category(
      books: books ?? this.books,
      title: title ?? this.title,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Category) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      books.hashCode ^
      title.hashCode ^
      iconName.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      id.hashCode;
}
