// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/user_model/otp_model.dart';
import 'package:fofo_app/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
import '../../models/profile/user_profile/user_profile.dart';
import '../../models/user_model/reset_password.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Loading,
  NotLoading,
  LoggedOut
}

const _STORE_ACCESS_TOKEN_KEY = "_store_access_token_key";
const _STORE_REFRESH_TOKEN_KEY = "_store_access_refresh_token_key";
const _STORE_USER_KEY = "_store_user_key";

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  UserModel? authUser;
  UserProfile? userProfile;
  String? token;

  late SharedPreferences _preferences;
  late DioClient dioClient;

  Future<void> init() async {
    dioClient = DioClient(Dio());
    _preferences = await SharedPreferences.getInstance();
    token = getToken();
    userProfile = getUser();
    getRefreshToken();
    // print('logged');
  }

  void logOut() async {
    await _preferences.clear();
  }

  void setToken(String token) {
    _preferences.setString(_STORE_ACCESS_TOKEN_KEY, token);
  }

  String getToken() {
    return _preferences.getString(_STORE_ACCESS_TOKEN_KEY) ?? "";
  }

  void setRefreshToken(String token) {
    _preferences.setString(_STORE_REFRESH_TOKEN_KEY, token);
  }

  String getRefreshToken() {
    return _preferences.getString(_STORE_REFRESH_TOKEN_KEY) ?? "";
  }

  void setUser(UserProfile user) {
    _preferences.setString(_STORE_USER_KEY, jsonEncode(user.toJson()));
  }

  UserProfile? getUser() {
    String? user = _preferences.getString(_STORE_USER_KEY);
    return user == null ? null : UserProfile.fromJson(jsonDecode(user));
  }

  Future<UserProfile?> getUserProfile(
      BuildContext context, String _token) async {
    try {
      Response response = await dioClient.get(context, "profile");
      return UserProfile.fromMap(response.data[0]);
    } catch (err) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      return null;
    }
  }

  Future<Map<String, dynamic>> login(
      BuildContext context, String email, String password) async {
    try {
      _loggedInStatus = Status.Authenticating;
      notifyListeners();
      Response response = await dioClient.post(context, "auth/login",
          data: {'email': email, 'password': password});
      _loggedInStatus = Status.LoggedIn;
      // print(response.data['accessToken']);
      token = response.data['accessToken'];
      setToken(response.data['accessToken']);
      setRefreshToken(response.data['refreshToken']);
      userProfile = await getUserProfile(context, response.data['accessToken']);
      // print(userProfile?.fullname);
      // ;
      if (userProfile == null) {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        return {
          'status': false,
          'message': "Invalid token, try logging in again"
        };
      }
      _loggedInStatus = Status.LoggedIn;
      setUser(userProfile!);

      notifyListeners();

      return {'status': true, 'message': "Login successful"};
    } catch (err) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      return {'status': false, 'message': err};
    }
  }

  // Future<Map<String, dynamic>>logOut()async{
  //   await
  // }

  Future<Map<String, dynamic>> register(
    BuildContext context,
    String fullname,
    String email,
    String phonenumber,
    String field,
    String password,
  ) async {
    final Map<String, dynamic> registrationData = {
      "fullname": fullname,
      "email": email,
      "phonenumber": phonenumber,
      "field": field,
      "password": password
    };
    _registeredInStatus = Status.Loading;
    notifyListeners();
    Response response;
    try {
      response = await dioClient.post(context, "auth/register",
          data: registrationData);
      print(response.data);
      final body = response.data;

      authUser = UserModel.fromMap(body);
      authUser = authUser!.copyWith(
          fullname: fullname,
          email: email,
          phonenumber: phonenumber,
          field: field,
          password: password);
      _registeredInStatus = Status.NotLoading;
      notifyListeners();
      return {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } catch (e) {
      _registeredInStatus = Status.NotLoading;
      notifyListeners();
      return {'status': false, 'message': e};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
      BuildContext context, String otp, String token) async {
    // var result;
    // const api = "https://fofoapp.herokuapp.com/api/auth/verifyotp";
    final bearerToken = token;
    final Map<String, dynamic> otpData = {"otp": otp};
    notifyListeners();
    Response response;

    try {
      response = await dioClient.post(context, "auth/verifyotp", data: otpData);

      final body = response.data;
      OtpModel otpCode = OtpModel.fromMap(body);
      notifyListeners();
      return {'status': true, 'message': 'Successful', 'user': otpCode};
    } catch (e) {
      _registeredInStatus = Status.NotLoading;
      notifyListeners();
      return {'status': false, 'message': e};
    }
    // response = await Dio().post(api,
    //     data: otpData,
    //     options: Options(
    //         responseType: ResponseType.json,
    //         headers: {"Authorization": "Bearer $bearerToken"}));
    // if (response.statusCode == 200) {
    //   final body = response.data;
    //   OtpModel otpCode = OtpModel.fromMap(body);
    //   notifyListeners();
    //   result = {'status': true, 'message': 'Successful', 'user': otpCode};
    // } else {
    //   notifyListeners();
    //   result = {'status': false, 'message': response.data['error']};
    // }
    // return result;
  }

  Future<Map<String, dynamic>?> uploadToServer(
      File image, String userId, String token) async {
    final fileName = image.path.split('/').last;
    final bearerToken = token;
    var formData = FormData.fromMap({
      "profileImage":
          await MultipartFile.fromFile(image.path, filename: fileName)
    });
    try {
      Response response = await Dio().post(
          'https://fofoapp.herokuapp.com/api/profile/upload-profile-image/' +
              userId,
          data: formData,
          options: Options(
              responseType: ResponseType.json,
              headers: {"Authorization": "Bearer $bearerToken"}));
      if (response.data != null) {
        final body = response.data;
      }
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    var result;
    const api = "https://fofoapp.herokuapp.com/api/auth/reset-password";
    final data = {"email": email};
    notifyListeners();
    Response response;
    response = await Dio().post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      UserModel resetPassword = UserModel.fromMap(body);
      notifyListeners();
      result = {'status': true, 'message': 'Successful', 'user': resetPassword};
    } else {
      notifyListeners();
      result = {'status': false, 'message': response.data['error']};
    }
    return result;
  }

  Future<Map<String, dynamic>> updatePassword(
      String password, String confirmPassword, String userId) async {
    var result;
    final data = {"password": password, "confirmPassword": confirmPassword};
    notifyListeners();
    Response response;
    response = await Dio().patch(
        "https://fofoapp.herokuapp.com/api/auth/update-password/" + userId,
        data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      ResetPassword updateUser = ResetPassword.fromMap(body);
      notifyListeners();
      result = {'status': true, 'message': 'Successful', 'user': updateUser};
    } else {
      notifyListeners();
      result = {'status': false, 'message': response.data['error']};
    }
    return result;
  }
}
