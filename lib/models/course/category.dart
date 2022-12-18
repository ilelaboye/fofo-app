import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Category {
  final String? id;
  final String? name;
  const Category({
    this.id,
    this.name,
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name)';
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        id: data['id'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
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
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
