import 'dart:convert';

import 'package:flutter/material.dart';

import './creator.dart';

@immutable
class Review {
  final String? id;
  final String? fullname;
  final Creator? reviewdBy;
  final String? comment;
  final String? createdAt;
  final String? courseId;
  final int rating;

  const Review(
      {this.id,
      this.fullname,
      this.reviewdBy,
      this.comment,
      this.createdAt,
      this.courseId,
      required this.rating});

  factory Review.fromMap(Map<String, dynamic> data) => Review(
        id: data['id'] as String?,
        fullname: data['fullname'] as String?,
        reviewdBy: data['reviewdBy'] == null
            ? null
            : Creator.fromMap(data['reviewdBy'] as Map<String, dynamic>),
        comment: data['comment'] as String?,
        createdAt: data['createdAt'] as String?,
        courseId: data['courseId'] as String?,
        rating: data['rating'] as int,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullname': fullname,
        'reviewdBy': reviewdBy,
        'comment': comment,
        'createdAt': createdAt,
        'courseId': courseId,
        'rating': rating
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Review].
  factory Review.fromJson(String data) {
    return Review.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      reviewdBy.hashCode ^
      fullname.hashCode ^
      comment.hashCode ^
      courseId.hashCode ^
      rating.hashCode ^
      createdAt.hashCode;
}
