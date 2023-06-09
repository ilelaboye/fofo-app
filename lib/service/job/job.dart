import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';

class JobProvider extends ChangeNotifier {
  Map? jobs;
  Map? job;
  // GetCourseById? course;

  DioClient dioClient = DioClient(Dio());
  Future getJobs(BuildContext context, {int nextPage = 1}) async {
    try {
      Response response =
          await dioClient.get(context, "jobs/alljobs?page=${nextPage}");
      print('get jobs data');
      print(response.data);
      jobs = response.data;
      print(jobs);
      notifyListeners();
      return jobs;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getJob(BuildContext context, String id) async {
    try {
      Response response = await dioClient.get(context, "jobs/" + id + "/get");

      print('get single job');

      job = response.data;
      // print(feed);
      notifyListeners();
      return job;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future searchJob(BuildContext context, String text) async {
    try {
      Response response =
          await dioClient.post(context, "jobs/search", data: {"name": text});

      print('search job');
      notifyListeners();
      return response.data;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }
}
