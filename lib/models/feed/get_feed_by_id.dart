import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/feed/comment.dart';

import 'feed.dart';

@immutable
class GetFeedById {
  final List<Feed> blog;
  final List<Comment>? blog_comments;

  const GetFeedById({
    required this.blog,
    this.blog_comments,
  });

  @override
  String toString() {
    return 'GetFeedById(blog: $blog, blog_comments: $blog_comments)';
  }

  factory GetFeedById.fromMap(Map<String, dynamic> data) => GetFeedById(
        blog: (data['blog'] as List<dynamic>)
            .map((e) => Feed.fromMap(e as Map<String, dynamic>))
            .toList(),
        blog_comments: (data['blog_comments'] as List<dynamic>)
            .map((e) => Comment.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'blog': blog.map((e) => e.toMap()).toList(),
        'blog_comments': blog_comments?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetFeedById].
  factory GetFeedById.fromJson(String data) {
    return GetFeedById.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetFeedById] to a JSON string.
  String toJson() => json.encode(toMap());

  GetFeedById copyWith({
    List<Feed>? blog,
    List<Comment>? blog_comments,
  }) {
    return GetFeedById(
      blog: blog ?? this.blog,
      blog_comments: blog_comments ?? this.blog_comments,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetFeedById) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => blog.hashCode ^ blog_comments.hashCode;
}
