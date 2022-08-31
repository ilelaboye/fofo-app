import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class ResetPassword {
  final String? password;
  final String? comfirmPassword;

  const ResetPassword({this.password, this.comfirmPassword});

  @override
  String toString() {
    return 'ResetPassword(password: $password, comfirmPassword: $comfirmPassword)';
  }

  factory ResetPassword.fromMap(Map<String, dynamic> data) => ResetPassword(
        password: data['password'] as String?,
        comfirmPassword: data['comfirmPassword'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'password': password,
        'comfirmPassword': comfirmPassword,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResetPassword].
  factory ResetPassword.fromJson(String data) {
    return ResetPassword.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ResetPassword] to a JSON string.
  String toJson() => json.encode(toMap());

  ResetPassword copyWith({
    String? password,
    String? comfirmPassword,
  }) {
    return ResetPassword(
      password: password ?? this.password,
      comfirmPassword: comfirmPassword ?? this.comfirmPassword,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ResetPassword) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => password.hashCode ^ comfirmPassword.hashCode;
}
