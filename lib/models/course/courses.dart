import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import './category.dart';
import './course.dart';

@immutable
class Courses {
  final List<Category>? categories;
  final List<Course>? courses;

  const Courses({this.categories, this.courses});

  @override
  String toString() {
    return 'Courses(categories: $categories, courses: $courses)';
  }

  factory Courses.fromMap(Map<String, dynamic> data) => Courses(
        categories: (data['categories']['docs'] as List<dynamic>)
            .map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        courses: (data['courses']['docs'] as List<dynamic>)
            .map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'categories': categories?.map((e) => e.toMap()).toList(),
        'courses': courses?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Courses].
  factory Courses.fromJson(String data) {
    return Courses.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Courses] to a JSON string.
  String toJson() => json.encode(toMap());

  Courses copyWith({List<Category>? categories, List<Course>? courses}) {
    return Courses(
      categories: categories ?? this.categories,
      courses: courses ?? this.courses,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Courses) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => categories.hashCode ^ courses.hashCode;
}
