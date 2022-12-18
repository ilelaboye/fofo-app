import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fofo_app/models/podcast/podcaster.dart';

import './category.dart';
import './podcast.dart';

@immutable
class Podcasts {
  final List<Category>? podcastCategories;
  final List<Podcast>? recentPlayed;
  final List<Podcast>? popular;
  final List<Podcast>? you_may_like;
  final List<Podcaster>? top_podcaster;

  const Podcasts(
      {this.podcastCategories,
      this.recentPlayed,
      this.popular,
      this.you_may_like,
      this.top_podcaster});

  @override
  String toString() {
    return 'Podcasts(podcastCategories: $podcastCategories, recentPlayed: $recentPlayed, popular: $popular, you_may_like: $you_may_like, top_podcaster: $top_podcaster)';
  }

  factory Podcasts.fromMap(Map<String, dynamic> data) => Podcasts(
        podcastCategories: (data['podcastCategories']['docs'] as List<dynamic>)
            .map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        recentPlayed: (data['recentPlayed']['docs'] as List<dynamic>)
            .map((e) => Podcast.fromMap(e as Map<String, dynamic>))
            .toList(),
        popular: (data['popular']['docs'] as List<dynamic>)
            .map((e) => Podcast.fromMap(e as Map<String, dynamic>))
            .toList(),
        you_may_like: (data['you_may_like']['docs'] as List<dynamic>)
            .map((e) => Podcast.fromMap(e as Map<String, dynamic>))
            .toList(),
        top_podcaster: (data['top_podcaster']['docs'] as List<dynamic>)
            .map((e) => Podcaster.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'podcastCategories': podcastCategories?.map((e) => e.toMap()).toList(),
        'recentPlayed': recentPlayed?.map((e) => e.toMap()).toList(),
        'popular': popular?.map((e) => e.toMap()).toList(),
        'you_may_like': you_may_like?.map((e) => e.toMap()).toList(),
        'top_podcaster': top_podcaster?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Podcasts].
  factory Podcasts.fromJson(String data) {
    return Podcasts.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Podcasts] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  int get hashCode =>
      podcastCategories.hashCode ^
      popular.hashCode ^
      you_may_like.hashCode ^
      top_podcaster.hashCode ^
      recentPlayed.hashCode;
}
