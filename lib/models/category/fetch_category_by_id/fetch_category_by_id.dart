import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'category.dart';

@immutable
class FetchCategoryById {
  final String? message;
  final Category? category;

  const FetchCategoryById({this.message, this.category});

  @override
  String toString() {
    return 'FetchCategoryById(message: $message, category: $category)';
  }

  factory FetchCategoryById.fromMap(Map<String, dynamic> data) {
    return FetchCategoryById(
      message: data['message'] as String?,
      category: data['category'] == null
          ? null
          : Category.fromMap(data['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'category': category?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FetchCategoryById].
  factory FetchCategoryById.fromJson(String data) {
    return FetchCategoryById.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FetchCategoryById] to a JSON string.
  String toJson() => json.encode(toMap());

  FetchCategoryById copyWith({
    String? message,
    Category? category,
  }) {
    return FetchCategoryById(
      message: message ?? this.message,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FetchCategoryById) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => message.hashCode ^ category.hashCode;
}
