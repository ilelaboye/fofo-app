import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class UserProfile {
  final String? fullname;
  final String? email;
  final dynamic about;
  final int? booksRead;
  final int? followers;
  final int? following;
  final String? id;
  final String? profileImage;
  final String? roles;
  final String? membershipType;
  final bool? isActive;
  final String? phonenumber;
  final bool? paid;

  const UserProfile(
      {this.fullname,
      this.email,
      this.about,
      this.booksRead,
      this.followers,
      this.following,
      this.id,
      this.profileImage,
      this.roles,
      this.membershipType,
      this.isActive,
      this.phonenumber,
      this.paid});

  @override
  String toString() {
    return 'UserProfile(fullname: $fullname,email: $email, about: $about, booksRead: $booksRead, followers: $followers, following: $following, id: $id,profileImage:$profileImage, roles: $roles, membershipType: $membershipType, isActive: $isActive,phonenumber: $phonenumber,paid: $paid)';
  }

  factory UserProfile.fromMap(Map<String, dynamic> data) => UserProfile(
      fullname: data['fullname'] as String?,
      email: data['email'] as String?,
      about: data['about'] as dynamic,
      booksRead: data['booksRead'] as int?,
      followers: data['followers'] as int?,
      following: data['following'] as int?,
      id: data['id'] as String?,
      roles: data['roles'] as String?,
      membershipType: data.containsKey('membershipType')
          ? data['membershipType'] as String?
          : null,
      profileImage:
          data.containsKey('profileImage') ? data['profileImage'] : null,
      isActive: data['isActive'] as bool?,
      phonenumber: data['phonenumber'] as String?,
      paid: data['paid'] as bool?);

  Map<String, dynamic> toMap() => {
        'fullname': fullname,
        'email': email,
        'about': about,
        'booksRead': booksRead,
        'followers': followers,
        'following': following,
        'id': id,
        'profileImage': profileImage,
        'roles': roles,
        'membershipType': membershipType,
        'isActive': isActive,
        'phonenumber': phonenumber,
        'paid': paid
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

  UserProfile copyWith(
      {String? fullname,
      dynamic about,
      int? booksRead,
      int? followers,
      int? following,
      String? id,
      String? profileImage,
      String? roles,
      bool? isActive}) {
    return UserProfile(
        fullname: fullname ?? this.fullname,
        about: about ?? this.about,
        booksRead: booksRead ?? this.booksRead,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        id: id ?? this.id,
        profileImage: profileImage ?? this.profileImage,
        roles: roles ?? this.roles,
        isActive: isActive ?? this.isActive);
  }
}
