import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class BookCategory {
  final String? name;
  final String? id;

  const BookCategory({this.name, this.id});

  @override
  String toString() {
    return 'BookCategory(name: $name, id: $id)';
  }

  factory BookCategory.fromMap(Map<String, dynamic> data) => BookCategory(
        name: data['name'] as String?,
        id: data['id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
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
    String? name,
    String? id,
  }) {
    return BookCategory(
      name: name ?? this.name,
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
  int get hashCode => name.hashCode ^ id.hashCode;
}
