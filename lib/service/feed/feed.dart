import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/features/feeds/presentation/feeds.dart';
import 'package:fofo_app/models/feed/comment.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/category/fetch_category_by_id/fetch_category_by_id.dart';
import '../../models/feed/feeds.dart';
import '../../models/feed/get_feed_by_id.dart';

class FeedsProvider extends ChangeNotifier {
  Feeds? feeds;
  GetFeedById? feed;
  Comment? comment;
  late Map blogs;

  DioClient dioClient = DioClient(Dio());
  Future getFeeds(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "blog/lists");
      print('get feeds data');

      feeds = Feeds.fromMap(response.data);
      print(feeds);
      notifyListeners();
      return feeds;
    } catch (err) {
      print('get feeds err');
      print(err);
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getBlogs(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "blog");
      blogs = response.data;
      // notifyListeners();
      return blogs;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getBlog(BuildContext context, String id) async {
    try {
      Response response = await dioClient.get(context, "blog/" + id + "/show");

      print('single blog');

      feed = GetFeedById.fromMap(response.data);
      print(feed);
      notifyListeners();
      return feed;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const FeedsPage()),
      );
    }
  }

  Future postComment(BuildContext context, String id, String text) async {
    try {
      Response response = await dioClient.post(
          context, "blog/" + id + "/comment/create",
          data: {"comment": text});
      comment = Comment.fromMap(response.data['blog_comment']);
      notifyListeners();
      return comment;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future<FetchCategoryById?> fetchCategoryById(
      BuildContext context, String categoryId) async {
    try {
      Response response = await dioClient.get(
          context, "library/category/" + categoryId + "/get");
      final fetchId = FetchCategoryById.fromMap(response.data);
      notifyListeners();
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }

    // final _token = Provider.of<AuthProvider>(context, listen: false).token;
    // final Response response = await Dio().get(
    //     'https://fofoapp.herokuapp.com/api/library/category/' +
    //         categoryId +
    //         '/get',
    //     options: Options(
    //         responseType: ResponseType.json,
    //         headers: {"Authorization": "Bearer $_token"}));
    // final fetchId = FetchCategoryById.fromMap(response.data);
    // debugPrint(fetchId.toString());
    // notifyListeners();
  }
}
