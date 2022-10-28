import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class BookCategory {
  final String? title;
  final String? id;

  const BookCategory({this.title, this.id});

  @override
  String toString() {
    return 'BookCategory(title: $title, id: $id)';
  }

  factory BookCategory.fromMap(Map<String, dynamic> data) => BookCategory(
        title: data['title'] as String?,
        id: data['id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookCategory].
  factory BookCategory.fromJson(String data) {
    return BookCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  BookCategory copyWith({
    String? title,
    String? id,
  }) {
    return BookCategory(
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BookCategory) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode;
}
