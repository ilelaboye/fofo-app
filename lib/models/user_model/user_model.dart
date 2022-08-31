import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String? fullname;
  final String? email;
  final String? phonenumber;
  final String? field;
  final String? password;
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  final String? otp;
  final String? message;

  const UserModel(
      {this.fullname,
      this.email,
      this.phonenumber,
      this.field,
      this.password,
      this.accessToken,
      this.refreshToken,
      this.userId,
      this.otp,
      this.message});

  @override
  String toString() {
    return 'UserModel(fullname: $fullname, email: $email, phonenumber: $phonenumber, field: $field, password: $password, accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, otp: $otp, message: $message)';
  }

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
      fullname: data['fullname'] as String?,
      email: data['email'] as String?,
      phonenumber: data['phonenumber'] as String?,
      field: data['field'] as String?,
      password: data['password'] as String?,
      accessToken: data['accessToken'] as String?,
      refreshToken: data['refreshToken'] as String?,
      userId: data['userId'] as String?,
      otp: data['otp'] as String?,
      message: data['message'] as String?);

  Map<String, dynamic> toMap() => {
        'fullname': fullname,
        'email': email,
        'phonenumber': phonenumber,
        'field': field,
        'password': password,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'userId': userId,
        'otp': otp,
        'message': message
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());

  UserModel copyWith(
      {String? fullname,
      String? email,
      String? phonenumber,
      String? field,
      String? password,
      String? accessToken,
      String? refreshToken,
      String? userId,
      String? otp,
      String? message}) {
    return UserModel(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phonenumber: phonenumber ?? this.phonenumber,
      field: field ?? this.field,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
      otp: otp ?? this.otp,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      fullname.hashCode ^
      email.hashCode ^
      phonenumber.hashCode ^
      field.hashCode ^
      password.hashCode ^
      accessToken.hashCode ^
      refreshToken.hashCode ^
      userId.hashCode ^
      otp.hashCode ^
      message.hashCode;
}
