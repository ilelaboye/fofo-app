import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/course/get_course_by_id.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../models/course/courses.dart';

class CoursesProvider extends ChangeNotifier {
  Courses? courses;
  GetCourseById? course;

  DioClient dioClient = DioClient(Dio());
  Future getCourses(BuildContext context) async {
    try {
      Response response = await dioClient.get(context, "course/list");
      print('get courses data');

      courses = Courses.fromMap(response.data);
      print(courses);
      notifyListeners();
      return courses;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }

  Future getCourse(BuildContext context, String id) async {
    try {
      print('get single course intro');
      print(id);
      Response response = await dioClient.get(context, "course/" + id + "/get");

      print('get single course');

      course = GetCourseById.fromMap(response.data);
      // print(feed);
      notifyListeners();
      return course;
    } catch (err) {
      showNotification(context, false, err);
      notifyListeners();
    }
  }
}
