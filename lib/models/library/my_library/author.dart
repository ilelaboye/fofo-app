import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Author {
  final String? id;
  final String? fullname;
  final String? email;
  final String? image_url;
  final String? image;

  const Author(
      {this.id, this.fullname, this.email, this.image_url, this.image});

  @override
  String toString() {
    return 'Author(id: $id, fullname: $fullname, email: $email, image_url: $image_url, image: $image)';
  }

  factory Author.fromMap(Map<String, dynamic> data) => Author(
        id: data['id'] as String?,
        fullname: data['fullname'] as String?,
        email: data['email'] as String?,
        image_url: data.containsKey('image_url') ? data['image_url'] : null,
        image: data.containsKey('image') ? data['image'] : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'image_url': image_url,
        'image': image
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Author].
  factory Author.fromJson(String data) {
    return Author.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Author] to a JSON string.
  String toJson() => json.encode(toMap());

  Author copyWith(
      {String? id,
      String? fullname,
      String? email,
      String? image_url,
      String? image}) {
    return Author(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      image_url: image_url ?? this.image_url,
      image: image ?? this.image,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      fullname.hashCode ^
      email.hashCode ^
      image_url.hashCode ^
      image.hashCode;
}
