import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Creator {
  final String? id;
  final String? fullname;
  final String? email;
  final String? profileImage;
  final String? createdAt;

  const Creator(
      {this.id, this.fullname, this.email, this.profileImage, this.createdAt});

  @override
  String toString() {
    return 'Creator(id: $id, fullname: $fullname, email: $email, profileImage: $profileImage, createdAt: $createdAt)';
  }

  factory Creator.fromMap(Map<String, dynamic> data) => Creator(
        id: data['id'] as String?,
        fullname: data['fullname'] as String?,
        email: data['email'] as String?,
        profileImage:
            data.containsKey('profileImage') ? data['profileImage'] : null,
        createdAt: data['createdAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'profileImage': profileImage,
        'createdAt': createdAt,
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
    String? email,
    String? profileImage,
    String? createdAt,
  }) {
    return Creator(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      fullname.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      profileImage.hashCode;
}
