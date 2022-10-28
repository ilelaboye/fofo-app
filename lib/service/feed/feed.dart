import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/category/fetch_category_by_id/fetch_category_by_id.dart';
import '../../models/feed/feeds.dart';

class FeedsProvider extends ChangeNotifier {
  Feeds? feeds;
  late Map blogs;

  DioClient dioClient = DioClient(Dio());
  Future getFeeds(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "blog/lists");

      feeds = Feeds.fromMap(response.data);
      notifyListeners();
      return feeds;
    } catch (err) {
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
      notifyListeners();
      return response.data[0];
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future postComment(BuildContext context, String id, String text) async {
    try {
      Response response = await dioClient
          .post(context, "blog/" + id + "/comment", data: {"comment": text});
      print('post comment');
      print(response.data);
      notifyListeners();
      // return Feed.fromMap(response.data[0]);
      return response.data[0];
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
