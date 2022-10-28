import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'category.dart';
import 'creator.dart';

@immutable
class Feed {
  final String id;
  final String title;
  final String? description;
  final String? blogImagePath;
  final String createdAt;
  final int? comments_count;
  final int? likes_count;
  final Creator? creator;
  final Creator? createdBy;
  final Creator? author;
  final Category? category_details;

  const Feed({
    required this.id,
    required this.title,
    this.description,
    this.blogImagePath,
    required this.createdAt,
    this.comments_count,
    this.likes_count,
    this.creator,
    this.createdBy,
    this.author,
    this.category_details,
  });

  @override
  String toString() {
    return 'Feed(id: $id, title: $title, description: $description, blogImagePath: $blogImagePath, createdAt: $createdAt, comments_count: $comments_count, likes_count: $likes_count, creator: $creator, author: $author,createdBy: $createdBy, category_details: $category_details)';
  }

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
      id: data['id'] as String,
      title: data['title'] as String,
      description: data['description'] as String?,
      blogImagePath: data['blogImage'] as String?,
      createdAt: data['createdAt'] as String,
      comments_count: data['comments_count'] as int?,
      likes_count: data['likes_count'] as int?,
      creator: data['creator'] == null
          ? null
          : Creator.fromMap(data['creator'] as Map<String, dynamic>),
      author: data['author'] == null
          ? null
          : Creator.fromMap(data['author'] as Map<String, dynamic>),
      createdBy: data['createdBy'] == null
          ? null
          : Creator.fromMap(data['createdBy'] as Map<String, dynamic>),
      category_details: data['category_details'] == null
          ? null
          : Category.fromMap(data['category_details'] as Map<String, dynamic>));

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'blogImagePath': blogImagePath,
        'createdAt': createdAt,
        'category_details': category_details,
        'creator': creator,
        'author': author,
        'createdBy': createdBy,
        'comments_count': comments_count,
        'likes_count': likes_count,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Feed].
  factory Feed.fromJson(String data) {
    return Feed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Feed] to a JSON string.
  String toJson() => json.encode(toMap());

  Feed copyWith({
    String? id,
    String? title,
    String? description,
    String? blogImagePath,
    String? createdAt,
    Category? category_details,
    Creator? creator,
    Creator? author,
    Creator? createdBy,
    int? comments_count,
    int? likes_count,
  }) {
    return Feed(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      blogImagePath: blogImagePath ?? this.blogImagePath,
      createdAt: createdAt ?? this.createdAt,
      category_details: category_details ?? this.category_details,
      creator: creator ?? this.creator,
      author: author ?? this.author,
      createdBy: createdBy ?? this.createdBy,
      comments_count: comments_count ?? this.comments_count,
      likes_count: likes_count ?? this.likes_count,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Feed) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      blogImagePath.hashCode ^
      createdAt.hashCode ^
      category_details.hashCode ^
      creator.hashCode ^
      author.hashCode ^
      createdBy.hashCode ^
      comments_count.hashCode ^
      likes_count.hashCode;
}
