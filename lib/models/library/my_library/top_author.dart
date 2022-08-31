import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class TopAuthor {
  final String? id;
  final List<String>? name;
  final List<String>? books;
  final int? totalBooksWritten;

  const TopAuthor({this.id, this.name, this.books, this.totalBooksWritten});

  @override
  String toString() {
    return 'TopAuthor(id: $id, name: $name, books: $books, totalBooksWritten: $totalBooksWritten)';
  }

  factory TopAuthor.fromMap(Map<String, dynamic> data) => TopAuthor(
        id: data['_id'] as String?,
        name: List.from(data['name']),
        books: List.from(data['books']),
        totalBooksWritten: data['totalBooksWritten'] as int?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'books': books,
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
    List<String>? name,
    List<String>? books,
    int? totalBooksWritten,
  }) {
    return TopAuthor(
      id: id ?? this.id,
      name: name ?? this.name,
      books: books ?? this.books,
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
      id.hashCode ^ name.hashCode ^ books.hashCode ^ totalBooksWritten.hashCode;
}
