import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/config/constants.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/utils/extensions.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/avatar_group.dart';
import 'package:fofo_app/core/widgets/categories.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/loader.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:fofo_app/features/podcast/presentation/podcast_item.dart';
import 'package:fofo_app/models/podcast/podcasts.dart';
import 'package:fofo_app/service/podcast/podcast.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class PodcastsPage extends StatefulWidget {
  const PodcastsPage({Key? key}) : super(key: key);

  @override
  State<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends State<PodcastsPage> {
  late final Podcasts podcasts;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getPodcasts();
  }

  getPodcasts() async {
    podcasts = await Provider.of<PodcastProvider>(context, listen: false)
        .getPodcasts(context);
    print('podcast loade');
    setState(() {
      EasyLoading.dismiss();
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Loader();
    } else {
      return Scaffold(
        appBar: const Appbar(title: "Podcast"),
        // bottomSheet: Container(
        //   height: 100,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     border: Border(
        //       top: BorderSide(
        //         color: AppColors.palette[300]!,
        //       ),
        //     ),
        //   ),
        //   padding: const EdgeInsets.symmetric(
        //       vertical: Insets.sm, horizontal: Insets.lg),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       ClipRRect(
        //         borderRadius: Corners.smBorder,
        //         child: LocalImage("podcast".png, height: 60, width: 60),
        //       ),
        //       Gap.sm,
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               "Don’t make me think: A common sense approach to career thinking • EP 10",
        //               style: context.textTheme.bodyMedium,
        //               maxLines: 2,
        //             ),
        //             Gap.xs,
        //             Text(
        //               "Host : Omoregie Johnson & Bella",
        //               style: context.textTheme.caption.size(12),
        //               maxLines: 2,
        //             ),
        //           ],
        //         ),
        //       ),
        //       Gap.lg,
        //       Container(
        //         padding: const EdgeInsets.all(Insets.sm),
        //         decoration: BoxDecoration(
        //           color: AppColors.palette[300],
        //           shape: BoxShape.circle,
        //         ),
        //         child: const Icon(
        //           PhosphorIcons.playFill,
        //           color: Colors.white,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                child: Column(
                  children: [
                    // TextInputField(
                    //   hintText: "Titles, authors & topics",
                    //   prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
                    // ),
                    // Gap.lg,
                    // CategorySection(
                    //   categories: [],
                    //   // categories: categoryItems(),
                    // ),
                    Gap.lg,
                    const SectionHeader(
                      "Recently Played",
                    ),
                    Gap.sm,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => PodcastPlayableItem(
                        canPlay: false,
                        podcast: podcasts.recentPlayed![index],
                      ),
                      itemCount: podcasts.recentPlayed!.length,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Popular"),
              ),
              Gap.sm,
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.lg : Insets.sm,
                      right:
                          index == podcasts.popular!.length - 1 ? Insets.lg : 0,
                    ),
                    child: PodcastListItem(podcast: podcasts.popular![index]),
                  ),
                  itemCount: podcasts.popular!.length,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("Top podcasters"),
              ),
              Gap.sm,
              SizedBox(
                height: 77,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.lg : Insets.sm,
                      right: index == podcasts.top_podcaster!.length - 1
                          ? Insets.lg
                          : 0,
                    ),
                    child: Column(
                      children: [
                        Avatar(
                          AppColors.colorList()[index],
                          data: CircleAvatar(
                              backgroundImage: podcasts.top_podcaster![index]
                                          .hosts![0]['image_url'] ==
                                      null
                                  ? AssetImage("user".png) as ImageProvider
                                  : NetworkImage(podcasts.top_podcaster![index]
                                      .hosts![0]['image_url']
                                      .toString())),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            podcasts.top_podcaster![index].name.toString(),
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: podcasts.top_podcaster!.length,
                ),
              ),
              Gap.lg,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: SectionHeader("You might like"),
              ),
              Gap.sm,
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Insets.lg : Insets.sm,
                      right: index == podcasts.you_may_like!.length - 1
                          ? Insets.lg
                          : 0,
                    ),
                    child: PodcastListItem(
                      podcast: podcasts.you_may_like![index],
                    ),
                  ),
                  itemCount: podcasts.you_may_like!.length,
                ),
              ),
              const Gap(50)
            ],
          ),
        ),
      );
    }
  }
}
