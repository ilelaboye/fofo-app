import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fofo_app/models/podcast/podcast.dart';

@immutable
class Category {
  final String? id;
  final String? name;
  final String slug;
  final List<Podcast>? podcasts;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.podcasts,
  });

  factory Category.fromMap(Map<String, dynamic> data) => Category(
      id: data['id'] as String,
      name: data['name'] as String,
      slug: data['slug'] as String,
      podcasts: (data['podCasts'] as List<dynamic>)
          .map((e) => Podcast.fromMap(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'slug': slug, 'podcasts': podcasts};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ slug.hashCode ^ podcasts.hashCode;
}
