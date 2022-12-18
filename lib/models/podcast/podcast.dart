import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class Podcast {
  final String id;
  final String name;
  final String? description;
  final String link;
  final String podcastImage;
  final List<Map>? hosts;

  const Podcast({
    required this.id,
    required this.name,
    this.description,
    required this.link,
    required this.podcastImage,
    this.hosts,
  });

  @override
  String toString() {
    return 'Podcast(id: $id, name: $name, description: $description, link: $link, podcastImage: $podcastImage, hosts: $hosts, )';
  }

  factory Podcast.fromMap(Map<String, dynamic> data) => Podcast(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String?,
      link: data['link'] as String,
      podcastImage: data['podcastImage'] as String,
      hosts: data.containsKey('hosts')
          ? (data['hosts'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList()
          : []);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'link': link,
        'podcastImage': podcastImage,
        'hosts': hosts,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Podcast].
  factory Podcast.fromJson(String data) {
    return Podcast.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Podcast] to a JSON string.
  String toJson() => json.encode(toMap());

  Podcast copyWith({
    String? id,
    String? name,
    String? description,
    String? link,
    String? podcastImage,
    List<Map>? hosts,
  }) {
    return Podcast(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      link: link ?? this.link,
      podcastImage: podcastImage ?? this.podcastImage,
      hosts: hosts ?? this.hosts,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Podcast) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      link.hashCode ^
      podcastImage.hashCode ^
      hosts.hashCode;
}
