import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import './creator.dart';

@immutable
class Course {
  final String id;
  final String name;
  final String? description;
  final String? courseImage;
  final String? createdAt;
  final String? duration;
  final String? accessType;
  final int ratings_avg;
  final List<Creator>? createdBy;

  const Course({
    required this.id,
    required this.name,
    this.description,
    this.courseImage,
    this.createdAt,
    this.duration,
    this.accessType,
    required this.ratings_avg,
    this.createdBy,
  });

  @override
  String toString() {
    return 'Course(id: $id, name: $name, description: $description, courseImage: $courseImage, createdAt: $createdAt, duration: $duration, accessType: $accessType,ratings_avg: $ratings_avg, createdBy: $createdBy, )';
  }

  factory Course.fromMap(Map<String, dynamic> data) => Course(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String?,
      courseImage: data['courseImage'] as String?,
      createdAt: data['createdAt'] as String,
      duration: data['duration'] as String?,
      accessType: data['accessType'] as String?,
      ratings_avg: data.containsKey('ratings_avg') ? data['ratings_avg'] : 0,
      createdBy: (data['createdBy'] as List<dynamic>)
          .map((e) => Creator.fromMap(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'courseImage': courseImage,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'duration': duration,
        'ratings_avg': ratings_avg,
        'accessType': accessType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Course].
  factory Course.fromJson(String data) {
    return Course.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Course] to a JSON string.
  String toJson() => json.encode(toMap());

  Course copyWith({
    String? id,
    String? name,
    String? description,
    String? courseImage,
    String? createdAt,
    List<Creator>? createdBy,
    String? duration,
    int? ratings_avg,
    String? accessType,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      courseImage: courseImage ?? this.courseImage,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      duration: duration ?? this.duration,
      ratings_avg: ratings_avg ?? this.ratings_avg,
      accessType: accessType ?? this.accessType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Course) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      courseImage.hashCode ^
      createdAt.hashCode ^
      createdBy.hashCode ^
      duration.hashCode ^
      ratings_avg.hashCode ^
      accessType.hashCode;
}
