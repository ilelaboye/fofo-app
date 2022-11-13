import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import './book.dart';
import './category.dart';
import './top_author.dart';

@immutable
class MyLibrary {
  final List<Category>? categories;
  final Book? continue_reading;
  final List<Book>? books_in_library;
  final List<Book>? trending_books;
  final List<TopAuthor>? top_authors;

  const MyLibrary({
    this.continue_reading,
    this.categories,
    this.books_in_library,
    this.trending_books,
    this.top_authors,
  });

  @override
  String toString() {
    return 'MyLibrary(continue_reading: $continue_reading, categories: $categories, books_in_library: $books_in_library,trending_books: $trending_books, top_authors: $top_authors)';
  }

  factory MyLibrary.fromMap(Map<String, dynamic> data) => MyLibrary(
        continue_reading: data['continue_reading'] == null
            ? null
            : Book.fromMap(data['continue_reading'] as Map<String, dynamic>),
        categories: (data['categories']['docs'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        books_in_library: (data['books_in_library']['docs'] as List<dynamic>?)
            ?.map((e) => Book.fromMap(e as Map<String, dynamic>))
            .toList(),
        trending_books: (data['trending_books']['docs'] as List<dynamic>?)
            ?.map((e) => Book.fromMap(e as Map<String, dynamic>))
            .toList(),
        top_authors: (data['top_authors']['docs'] as List<dynamic>?)
            ?.map((e) => TopAuthor.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'continue_reading': continue_reading?.toMap(),
        'categories': categories?.map((e) => e.toMap()).toList(),
        'books_in_library': books_in_library?.map((e) => e.toMap()).toList(),
        'trending_books': trending_books?.map((e) => e.toMap()).toList(),
        'top_authors': top_authors?.map((e) => e.toMap()).toList(),
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
    Book? continue_reading,
    List<Category>? categories,
    List<Book>? books_in_library,
    List<Book>? trending_books,
    List<TopAuthor>? top_authors,
  }) {
    return MyLibrary(
      continue_reading: continue_reading ?? this.continue_reading,
      categories: categories ?? this.categories,
      books_in_library: books_in_library ?? this.books_in_library,
      trending_books: trending_books ?? this.trending_books,
      top_authors: top_authors ?? this.top_authors,
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
      continue_reading.hashCode ^
      categories.hashCode ^
      books_in_library.hashCode ^
      trending_books.hashCode ^
      top_authors.hashCode;
}
