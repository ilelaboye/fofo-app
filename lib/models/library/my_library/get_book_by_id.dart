import 'package:flutter/material.dart';

import 'book.dart';

@immutable
class GetBookById {
  final Book book;
  final List<Book>? similar_books;
  final List<Map>? reviews;
  final List<Map>? people_who_read;

  const GetBookById(
      {required this.book,
      this.similar_books,
      this.reviews,
      this.people_who_read});

  @override
  String toString() {
    return 'GetBookById(book: $book, similar_books:$similar_books, reviews: $reviews, people_who_read: $people_who_read)';
  }

  factory GetBookById.fromMap(Map<String, dynamic> data) => GetBookById(
        book: Book.fromMap(data['book'] as Map<String, dynamic>),
        similar_books: (data['similar_books']['docs'] as List<dynamic>?)
            ?.map((e) => Book.fromMap(e as Map<String, dynamic>))
            .toList(),
        reviews: (data['reviews']['docs'] as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
        people_who_read: (data['people_who_read']['docs'] as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
      );

  @override
  int get hashCode =>
      book.hashCode ^
      similar_books.hashCode ^
      reviews.hashCode ^
      people_who_read.hashCode;
}
