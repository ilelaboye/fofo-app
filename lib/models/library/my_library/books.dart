import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'book.dart';
import 'pagination_data.dart';

@immutable
class Books {
  final List<Book> books;
  final PaginationData? paginationData;

  const Books({
    required this.books,
    this.paginationData,
  });

  @override
  String toString() {
    return 'Books(books: $books, paginationData: $paginationData)';
  }

  factory Books.fromMap(Map<String, dynamic> data) => Books(
        books: (data['books'] as List<dynamic>)
            .map((e) => Book.fromMap(e as Map<String, dynamic>))
            .toList(),
        paginationData: data['paginationData'] == null
            ? null
            : PaginationData.fromMap(
                data['paginationData'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'books': books.map((e) => e.toMap()).toList(),
        'pagination': paginationData?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Books].
  factory Books.fromJson(String data) {
    return Books.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Books] to a JSON string.
  String toJson() => json.encode(toMap());

  Books copyWith({
    List<Book>? books,
    PaginationData? paginationData,
  }) {
    return Books(
      books: books ?? this.books,
      paginationData: paginationData ?? this.paginationData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Books) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => books.hashCode ^ paginationData.hashCode;
}
