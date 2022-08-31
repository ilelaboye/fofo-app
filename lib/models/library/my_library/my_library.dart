import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'category.dart';
import 'pagination_data.dart';
import 'top_author.dart';

@immutable
class MyLibrary {
  final String? message;
  final List<Category>? categories;
  final List<dynamic>? myLibrary;
  final List<TopAuthor>? topAuthors;
  final PaginationData? paginationData;

  const MyLibrary({
    this.message,
    this.categories,
    this.myLibrary,
    this.topAuthors,
    this.paginationData,
  });

  @override
  String toString() {
    return 'MyLibrary(message: $message, categories: $categories, myLibrary: $myLibrary, topAuthors: $topAuthors, paginationData: $paginationData)';
  }

  factory MyLibrary.fromMap(Map<String, dynamic> data) => MyLibrary(
        message: data['message'] as String?,
        categories: (data['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        myLibrary: data['myLibrary'] as List<dynamic>?,
        topAuthors: (data['topAuthors'] as List<dynamic>?)
            ?.map((e) => TopAuthor.fromMap(e as Map<String, dynamic>))
            .toList(),
        paginationData: data['paginationData'] == null
            ? null
            : PaginationData.fromMap(
                data['paginationData'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'categories': categories?.map((e) => e.toMap()).toList(),
        'myLibrary': myLibrary,
        'topAuthors': topAuthors?.map((e) => e.toMap()).toList(),
        'paginationData': paginationData?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MyLibrary].
  factory MyLibrary.fromJson(String data) {
    return MyLibrary.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MyLibrary] to a JSON string.
  String toJson() => json.encode(toMap());

  MyLibrary copyWith({
    String? message,
    List<Category>? categories,
    List<dynamic>? myLibrary,
    List<TopAuthor>? topAuthors,
    PaginationData? paginationData,
  }) {
    return MyLibrary(
      message: message ?? this.message,
      categories: categories ?? this.categories,
      myLibrary: myLibrary ?? this.myLibrary,
      topAuthors: topAuthors ?? this.topAuthors,
      paginationData: paginationData ?? this.paginationData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MyLibrary) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      message.hashCode ^
      categories.hashCode ^
      myLibrary.hashCode ^
      topAuthors.hashCode ^
      paginationData.hashCode;
}
