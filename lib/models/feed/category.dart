import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Category {
  final String? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  const Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt,)';
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        id: data['id'] as String?,
        name: data['name'] as String?,
        createdAt: data['createdAt'] ?? data['createdAt'] as String?,
        updatedAt: data['updatedAt'] ?? data['updatedAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
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
    String? createdAt,
    String? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ name.hashCode;
}
