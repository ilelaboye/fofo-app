import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class OtpModel {
  final String? otp;

  const OtpModel({this.otp});

  @override
  String toString() => 'OtpModel(otp: $otp)';

  factory OtpModel.fromMap(Map<String, dynamic> data) => OtpModel(
        otp: data['otp'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'otp': otp,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OtpModel].
  factory OtpModel.fromJson(String data) {
    return OtpModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OtpModel] to a JSON string.
  String toJson() => json.encode(toMap());

  OtpModel copyWith({
    String? otp,
  }) {
    return OtpModel(
      otp: otp ?? this.otp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OtpModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => otp.hashCode;
}
