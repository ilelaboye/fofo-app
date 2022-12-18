import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Podcaster {
  final String? id;
  final String? name;
  final List<Map>? hosts;

  const Podcaster({
    this.id,
    this.name,
    this.hosts,
  });

  factory Podcaster.fromMap(Map<String, dynamic> data) => Podcaster(
      id: data['id'] as String,
      name: data['name'] as String,
      hosts: (data['hosts'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'hosts': hosts,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Podcaster].
  factory Podcaster.fromJson(String data) {
    return Podcaster.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  int get hashCode => id.hashCode ^ hosts.hashCode ^ name.hashCode;
}
