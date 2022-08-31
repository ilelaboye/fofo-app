import 'package:dio/dio.dart';
import 'package:fofo_app/core/utils/constants/constants.dart';
import 'package:fofo_app/models/profile/user_profile/user_profile.dart';

class ProfileService implements GetUserProfile {
  @override
  Future<UserProfile?> getUserProfile() async {
    const api = "https://fofoapp.herokuapp.com/api/profile";

    Response response;
    try {
      response = await Dio().get(api,
          options: Options(responseType: ResponseType.json, headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyYzlhZTk4ZGM2YmZmMDQ5MmU0MDg4MiIsInVzZXJuYW1lIjoiaWtwb25td29zYSIsImVtYWlsIjoiaWtwb0BnbWFpbC5jb20iLCJyb2xlcyI6InVzZXIiLCJpYXQiOjE2NTczODUwMTEsImV4cCI6MTY1NzM4NjgxMSwiYXVkIjoiNjJjOWFlOThkYzZiZmYwNDkyZTQwODgyIiwiaXNzIjoieW91cndlYnNpdGVuYW1lLmNvbSJ9.rEHlNehWaSWNsAKqryeCwr1rOGNvITYCQu3EihAwrSo"
          }));
      if (response.statusCode == 200) {
        return UserProfile.fromMap(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
