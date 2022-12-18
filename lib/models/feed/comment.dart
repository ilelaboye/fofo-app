import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fofo_app/models/feed/creator.dart';

@immutable
class Comment {
  final String? id;
  final String? blogId;
  final Creator? commentedBy;
  final Creator? createdBy;
  final String comment;
  final String? createdAt;

  const Comment(
      {this.id,
      this.blogId,
      this.commentedBy,
      this.createdBy,
      required this.comment,
      this.createdAt});

  @override
  String toString() {
    return 'Comment(id: $id, blogId: $blogId,commentedBy: $commentedBy,createdBy: $createdBy, comment: $comment, createdAt: $createdAt)';
  }

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        id: data['id'] as String?,
        blogId: data['blogId'] as String?,
        commentedBy: data['commentedBy'] == null
            ? null
            : Creator.fromMap(data['commentedBy'] as Map<String, dynamic>),
        createdBy: data['createdBy'] == null
            ? null
            : Creator.fromMap(data['createdBy'] as Map<String, dynamic>),
        comment: data['comment'] as String,
        createdAt: data['createdAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'blogId': blogId,
        'commentedBy': commentedBy,
        'createdBy': createdBy,
        'comment': comment,
        'createdAt': createdAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Comment].
  factory Comment.fromJson(String data) {
    return Comment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Comment] to a JSON string.
  String toJson() => json.encode(toMap());

  Comment copyWith({
    String? id,
    String? blogId,
    Creator? commentedBy,
    Creator? createdBy,
    String? comment,
    String? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      blogId: blogId ?? this.blogId,
      commentedBy: commentedBy ?? this.commentedBy,
      createdBy: createdBy ?? this.createdBy,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      commentedBy.hashCode ^
      createdBy.hashCode ^
      blogId.hashCode ^
      comment.hashCode ^
      createdAt.hashCode;
}
