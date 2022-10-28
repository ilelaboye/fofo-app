import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'feed.dart';
import 'pagination.dart';

@immutable
class Feeds {
  final List<Feed> blogs;
  final PaginationData? paginationData;

  const Feeds({
    required this.blogs,
    this.paginationData,
  });

  @override
  String toString() {
    return 'Feeds(blogs: $blogs paginationData: $paginationData)';
  }

  factory Feeds.fromMap(Map<String, dynamic> data) => Feeds(
        blogs: (data['blogs'] as List<dynamic>)
            .map((e) => Feed.fromMap(e as Map<String, dynamic>))
            .toList(),
        paginationData: data['paginationData'] == null
            ? null
            : PaginationData.fromMap(
                data['paginationData'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'blogs': blogs.map((e) => e.toMap()).toList(),
        'pagination': paginationData?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Feeds].
  factory Feeds.fromJson(String data) {
    return Feeds.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Feeds] to a JSON string.
  String toJson() => json.encode(toMap());

  Feeds copyWith({
    List<Feed>? blogs,
    PaginationData? paginationData,
  }) {
    return Feeds(
      blogs: blogs ?? this.blogs,
      paginationData: paginationData ?? this.paginationData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Feeds) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => blogs.hashCode ^ paginationData.hashCode;
}
