import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'book.dart';

@immutable
class Category {
  final List<Book>? books;
  final String? name;
  final dynamic iconName;
  final String? id;

  const Category({this.books, this.name, this.iconName, this.id});

  @override
  String toString() {
    return 'Category(books: $books, name: $name, iconName: $iconName, id: $id)';
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        books: (data['books'] as List<dynamic>?)
            ?.map((e) => Book.fromMap(e as Map<String, dynamic>))
            .toList(),
        name: data['name'] as String?,
        iconName: data['iconName'] as dynamic,
        id: data['id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'books': books,
        'name': name,
        'iconName': iconName,
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
    List<Book>? books,
    String? name,
    dynamic iconName,
    String? id,
  }) {
    return Category(
      books: books ?? this.books,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
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
      books.hashCode ^ name.hashCode ^ iconName.hashCode ^ id.hashCode;
}
