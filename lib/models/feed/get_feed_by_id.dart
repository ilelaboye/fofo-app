import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/feed/comment.dart';

import 'feed.dart';

@immutable
class GetFeedById {
  final Feed blog;
  final List<Feed>? popular;
  final List<Comment>? blogComments;

  const GetFeedById({
    required this.blog,
    this.popular,
    this.blogComments,
  });

  @override
  String toString() {
    return 'GetFeedById(blog: $blog, popular:$popular, blogComments: $blogComments)';
  }

  factory GetFeedById.fromMap(Map<String, dynamic> data) => GetFeedById(
        blog: Feed.fromMap(data['blog'] as Map<String, dynamic>),
        popular: (data['popular'] as List<dynamic>)
            .map((e) => Feed.fromMap(e as Map<String, dynamic>))
            .toList(),
        blogComments: (data['blogComments']['docs'] as List<dynamic>)
            .map((e) => Comment.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'blog': blog.toMap(),
        'popular': popular?.map((e) => e.toMap()).toList(),
        'blogComments': blogComments?.map((e) => e.toMap()).toList(),
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
    Feed? blog,
    List<Feed>? popular,
    List<Comment>? blogComments,
  }) {
    return GetFeedById(
      blog: blog ?? this.blog,
      popular: popular ?? this.popular,
      blogComments: blogComments ?? this.blogComments,
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
  int get hashCode => blog.hashCode ^ popular.hashCode ^ blogComments.hashCode;
}
