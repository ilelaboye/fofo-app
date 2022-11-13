import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/feed/category.dart';

import './feed.dart';

@immutable
class Feeds {
  final List<Category>? categories;
  final Feed? hot;
  final List<Feed>? recent;
  final List<Feed>? popular;

  const Feeds({this.categories, this.hot, this.recent, this.popular});

  @override
  String toString() {
    return 'Feeds(categories: $categories, hot: $hot, recent: $recent, popular: $popular)';
  }

  factory Feeds.fromMap(Map<String, dynamic> data) => Feeds(
        categories: (data['categories']['docs'] as List<dynamic>)
            .map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        hot: data['hot'] == null
            ? null
            : Feed.fromMap(data['hot'] as Map<String, dynamic>),
        recent: (data['recent']['docs'] as List<dynamic>)
            .map((e) => Feed.fromMap(e as Map<String, dynamic>))
            .toList(),
        popular: (data['popular']['docs'] as List<dynamic>)
            .map((e) => Feed.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'categories': categories?.map((e) => e.toMap()).toList(),
        'hot': hot?.toMap(),
        'recent': recent?.map((e) => e.toMap()).toList(),
        'popular': popular?.map((e) => e.toMap()).toList(),
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

  Feeds copyWith(
      {List<Category>? categories,
      Feed? hot,
      List<Feed>? recent,
      List<Feed>? popular}) {
    return Feeds(
      categories: categories ?? this.categories,
      hot: hot ?? this.hot,
      recent: recent ?? this.recent,
      popular: popular ?? this.popular,
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
  int get hashCode =>
      categories.hashCode ^ hot.hashCode ^ popular.hashCode ^ recent.hashCode;
}
