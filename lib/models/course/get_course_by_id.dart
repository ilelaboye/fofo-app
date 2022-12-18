import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import './course.dart';
import './review.dart';

@immutable
class GetCourseById {
  final Course course;
  final List<Course> similar;
  final List<Review> course_reviews;

  const GetCourseById({
    required this.course,
    required this.similar,
    required this.course_reviews,
  });

  @override
  String toString() {
    return 'GetCourseById(course: $course, similar:$similar, course_reviews: $course_reviews)';
  }

  factory GetCourseById.fromMap(Map<String, dynamic> data) => GetCourseById(
        course: Course.fromMap(data['course'] as Map<String, dynamic>),
        similar: (data['similar']['docs'] as List<dynamic>)
            .map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList(),
        course_reviews: (data['course_reviews']['docs'] as List<dynamic>)
            .map((e) => Review.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'course': course.toMap(),
        'similar': similar.map((e) => e.toMap()).toList(),
        'course_reviews': course_reviews.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetCourseById].
  factory GetCourseById.fromJson(String data) {
    return GetCourseById.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetCourseById] to a JSON string.
  String toJson() => json.encode(toMap());

  GetCourseById copyWith({
    Course? course,
    List<Course>? similar,
    List<Review>? course_reviews,
  }) {
    return GetCourseById(
      course: course ?? this.course,
      similar: similar ?? this.similar,
      course_reviews: course_reviews ?? this.course_reviews,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetCourseById) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      course.hashCode ^ similar.hashCode ^ course_reviews.hashCode;
}
