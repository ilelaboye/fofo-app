import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class UserProfile {
  final String? fullname;
  final dynamic about;
  final int? booksRead;
  final int? followers;
  final int? following;
  final String? id;
  final String? profileImage;
  final String? roles;

  const UserProfile({
    this.fullname,
    this.about,
    this.booksRead,
    this.followers,
    this.following,
    this.id,
    this.profileImage,
    this.roles,
  });

  @override
  String toString() {
    return 'UserProfile(fullname: $fullname, about: $about, booksRead: $booksRead, followers: $followers, following: $following, id: $id,profileImage:$profileImage, roles: $roles)';
  }

  factory UserProfile.fromMap(Map<String, dynamic> data) => UserProfile(
      fullname: data['fullname'] as String?,
      about: data['about'] as dynamic,
      booksRead: data['booksRead'] as int?,
      followers: data['followers'] as int?,
      following: data['following'] as int?,
      id: data['id'] as String?,
      roles: data['roles'] as String?,
      profileImage:
          data.containsKey('profileImage') ? data['profileImage'] : null);

  Map<String, dynamic> toMap() => {
        'fullname': fullname,
        'about': about,
        'booksRead': booksRead,
        'followers': followers,
        'following': following,
        'id': id,
        'profileImage': profileImage,
        'roles': roles,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserProfile].
  factory UserProfile.fromJson(String data) {
    return UserProfile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserProfile] to a JSON string.
  String toJson() => json.encode(toMap());

  UserProfile copyWith({
    String? fullname,
    dynamic about,
    int? booksRead,
    int? followers,
    int? following,
    String? id,
    String? profileImage,
    String? roles,
  }) {
    return UserProfile(
      fullname: fullname ?? this.fullname,
      about: about ?? this.about,
      booksRead: booksRead ?? this.booksRead,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      roles: roles ?? this.roles,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserProfile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      fullname.hashCode ^
      about.hashCode ^
      booksRead.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      id.hashCode ^
      profileImage.hashCode ^
      roles.hashCode;
}
