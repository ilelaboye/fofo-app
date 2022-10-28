import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Author {
  final String? id;
  final String? fullname;
  final String? email;
  final String? profileImage;

  const Author({this.id, this.fullname, this.email, this.profileImage});

  @override
  String toString() {
    return 'Author(id: $id, fullname: $fullname, email: $email, profileImage: $profileImage)';
  }

  factory Author.fromMap(Map<String, dynamic> data) => Author(
        id: data['id'] as String?,
        fullname: data['fullname'] as String?,
        email: data['email'] as String?,
        profileImage: data['profileImage'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'profileImage': profileImage,
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

  Author copyWith({
    String? id,
    String? fullname,
    String? email,
    String? profileImage,
  }) {
    return Author(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ fullname.hashCode ^ email.hashCode ^ profileImage.hashCode;
}
