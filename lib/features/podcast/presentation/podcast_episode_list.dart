import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/features/podcast/presentation/podcast_item.dart';

class PodcastEpisodesListPage extends StatelessWidget {
  const PodcastEpisodesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "All Episodes"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.md,
            const Text("Showing all episodes"),
            Gap.md,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  const PodcastPlayableItem(canPlay: true),
              itemCount: 10,
            ),
          ],
        ),
      )),
    );
  }
}
