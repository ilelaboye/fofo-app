import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class PaginationData {
  final int? totalRecords;
  final int? currentPage;
  final int? perPage;
  final int? totalPages;

  const PaginationData({
    this.totalRecords,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  @override
  String toString() {
    return 'PaginationData(totalRecords: $totalRecords, currentPage: $currentPage, perPage: $perPage, totalPages: $totalPages)';
  }

  factory PaginationData.fromMap(Map<String, dynamic> data) {
    return PaginationData(
      totalRecords: data['totalRecords'] as int?,
      currentPage: data['currentPage'] as int?,
      perPage: data['perPage'] as int?,
      totalPages: data['totalPages'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'totalRecords': totalRecords,
        'currentPage': currentPage,
        'perPage': perPage,
        'totalPages': totalPages,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaginationData].
  factory PaginationData.fromJson(String data) {
    return PaginationData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaginationData] to a JSON string.
  String toJson() => json.encode(toMap());

  PaginationData copyWith({
    int? totalRecords,
    int? currentPage,
    int? perPage,
    int? totalPages,
  }) {
    return PaginationData(
      totalRecords: totalRecords ?? this.totalRecords,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PaginationData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      totalRecords.hashCode ^
      currentPage.hashCode ^
      perPage.hashCode ^
      totalPages.hashCode;
}
