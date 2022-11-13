import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import './category.dart';
import './creator.dart';

@immutable
class Feed {
  final String id;
  final String name;
  final String? description;
  final String? blogImage;
  final String createdAt;
  final int? comments_count;
  final int? blogLikes;
  final int? blogviews;
  final Creator? createdBy;
  final Category? blogCategory;

  const Feed({
    required this.id,
    required this.name,
    this.description,
    this.blogImage,
    required this.createdAt,
    this.comments_count,
    this.blogLikes,
    this.blogviews,
    this.createdBy,
    this.blogCategory,
  });

  @override
  String toString() {
    return 'Feed(id: $id, name: $name, description: $description, blogImage: $blogImage, createdAt: $createdAt, comments_count: $comments_count, blogLikes: $blogLikes, blogviews: $blogviews, createdBy: $createdBy, blogCategory: $blogCategory)';
  }

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String?,
      blogImage: data['blogImage'] as String?,
      createdAt: data['createdAt'] as String,
      comments_count: data['comments_count'] as int?,
      blogLikes: data['blogLikes'] as int?,
      blogviews: data['blogviews'] as int?,
      createdBy: Creator.fromMap(const {
        'id': "63610ccb81258a248e490130",
        'fullname': "Fullname String",
        'createdAt': "2022-11-01T12:10:52.026Z",
        'profileImage':
            "https://res.cloudinary.com/trailblazerfemme-app/image/upload/v1667938404/fcjlfybrxhhkoh9zezju.jpg",
      }),
      // createdBy: data['createdBy'] == null
      //     ? null
      //     : Creator.fromMap(data['createdBy'] as Map<String, dynamic>),
      blogCategory: data['blogCategory'] == null
          ? null
          : Category.fromMap(data['blogCategory'] as Map<String, dynamic>));

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'blogImage': blogImage,
        'createdAt': createdAt,
        'blogCategory': blogCategory,
        'blogviews': blogviews,
        'createdBy': createdBy,
        'comments_count': comments_count,
        'blogLikes': blogLikes,
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
    String? name,
    String? description,
    String? blogImage,
    String? createdAt,
    Category? blogCategory,
    Creator? createdBy,
    int? comments_count,
    int? blogLikes,
    int? blogviews,
  }) {
    return Feed(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      blogImage: blogImage ?? this.blogImage,
      createdAt: createdAt ?? this.createdAt,
      blogCategory: blogCategory ?? this.blogCategory,
      blogviews: blogviews ?? this.blogviews,
      createdBy: createdBy ?? this.createdBy,
      comments_count: comments_count ?? this.comments_count,
      blogLikes: blogLikes ?? this.blogLikes,
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
      name.hashCode ^
      description.hashCode ^
      blogImage.hashCode ^
      createdAt.hashCode ^
      blogCategory.hashCode ^
      blogviews.hashCode ^
      createdBy.hashCode ^
      comments_count.hashCode ^
      blogLikes.hashCode;
}
