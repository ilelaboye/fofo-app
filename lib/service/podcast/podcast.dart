import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/podcast/podcasts.dart';

class PodcastProvider extends ChangeNotifier {
  Podcasts? podcasts;
  // GetCourseById? course;

  DioClient dioClient = DioClient(Dio());
  Future getPodcasts(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "podcast");
      print('get podcasts data');
      print(response.data);
      podcasts = Podcasts.fromMap(response.data);
      print(podcasts);
      notifyListeners();
      return podcasts;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  // Future getPodcast(BuildContext context, String id) async {
  //   try {
  //     Response response = await dioClient.get(context, "podcast/" + id + "/search");
  //
  //     print('get single course');
  //
  //     course = GetCourseById.fromMap(response.data);
  //     // print(feed);
  //     notifyListeners();
  //     return course;
  //   } catch (err) {
  //     showNotification(context, false, err);
  //     notifyListeners();
  //   }
  // }
}
