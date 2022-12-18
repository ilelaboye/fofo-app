import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Creator {
  final String? id;
  final String fullname;
  final String? image_url;

  const Creator({this.id, required this.fullname, this.image_url});

  @override
  String toString() {
    return 'Creator(id: $id, fullname: $fullname, image_url: $image_url)';
  }

  factory Creator.fromMap(Map<String, dynamic> data) => Creator(
        id: data['id'] as String?,
        fullname: data['fullname'] as String,
        image_url: data['image_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullname': fullname,
        'image_url': image_url,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Creator].
  factory Creator.fromJson(String data) {
    return Creator.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Creator] to a JSON string.
  String toJson() => json.encode(toMap());

  Creator copyWith({
    String? id,
    String? fullname,
    String? image_url,
  }) {
    return Creator(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      image_url: image_url ?? this.image_url,
    );
  }

  @override
  int get hashCode => id.hashCode ^ fullname.hashCode ^ image_url.hashCode;
}
