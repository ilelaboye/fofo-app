// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fofo_app/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
import '../../core/widgets/notification.dart';
import '../../features/auth/presentation/login.dart';
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
    notifyListeners();
    // print('logged');
  }

  void logOut(BuildContext context) async {
    await _preferences.clear();
    skipOnboarding();
    setToken("null");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
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

  void skipOnboarding() {
    _preferences.setBool("skipOnboard", true);
  }

  bool getSkipOnboarding() {
    return _preferences.getBool("skipOnboard") ?? false;
  }

  UserProfile? getUser() {
    String? user = _preferences.getString(_STORE_USER_KEY);
    return user == null ? null : UserProfile.fromJson(jsonDecode(user));
  }

  Future<UserProfile?> getUserProfile(
      BuildContext context, String _token) async {
    try {
      print('get profile');
      EasyLoading.show(status: 'loading...');
      Response response = await dioClient.get(context, "profile");
      print('profile resp');
      print(response.data['profile']);
      EasyLoading.dismiss();
      return UserProfile.fromMap(response.data['profile']);
    } catch (err) {
      EasyLoading.dismiss();
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
      token = response.data['accessToken'];
      setToken(response.data['accessToken']);
      setRefreshToken(response.data['refreshToken']);
      print(response.data['accessToken']);
      userProfile = await getUserProfile(context, response.data['accessToken']);
      print('login after');
      print(userProfile);
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
      Map body = response.data;

      print('register...');
      print(body);
      token = body['accessToken'];
      setToken(body['accessToken'] as String);
      _registeredInStatus = Status.NotLoading;
      notifyListeners();
      return {
        'status': true,
        'message': 'Successfully registered',
        'data': body
      };
    } catch (e) {
      _registeredInStatus = Status.NotLoading;
      notifyListeners();
      print('signup error');
      print(e);
      return {'status': false, 'message': e};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
      BuildContext context, String otp, String token) async {
    final Map<String, dynamic> otpData = {"otp": otp};
    Response response;
    print('before otp ve');
    try {
      response = await dioClient.post(context, "auth/verifyotp", data: otpData);
      print('verify otp resp');
      print(response);
      notifyListeners();
      return {'status': true, 'message': 'Otp verified successfully'};
    } catch (e) {
      print('verify otp error');
      print(e);
      notifyListeners();
      return {'status': false, 'message': e};
    }
  }

  Future<Map<String, dynamic>?> uploadToServer(
      BuildContext context, File image, String userId, String token) async {
    final fileName = image.path.split('/').last;

    var formData = FormData.fromMap({
      "profileImage":
          await MultipartFile.fromFile(image.path, filename: fileName)
    });

    Response response;
    try {
      response = await dioClient.patch(
          context, 'profile/update-profile-image/' + userId,
          data: formData);

      print('upload');
      print(response.data);
      if (response.data != null) {
        final body = response.data;
      }
      notifyListeners();
      return {
        'status': true,
        'message': 'Profile image uploaded successfully',
        'data': response.data
      };
    } catch (e) {
      notifyListeners();
      print('error upload');
      return {'status': false, 'message': e};
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      BuildContext context, String email) async {
    var result;
    // const api = "https://fofoapp.herokuapp.com/api/auth/reset-password";
    final data = {"email": email};
    // notifyListeners();
    Response response;
    response = await dioClient.post(context, "auth/reset-password", data: data);
    // final body = response.data;
    // response = await Dio().post(api, data: data);
    print('reset resp');
    print(response);
    if (response.statusCode == 200) {
      final body = response.data;
      UserModel resetPassword = UserModel.fromMap(body);
      notifyListeners();
      result = {'status': true, 'message': 'Successful', 'user': resetPassword};
    } else {
      print('reset error');
      print(response);
      notifyListeners();
      result = {'status': false, 'message': response.data['error']};
    }
    return result;
  }

  Future<Map<String, dynamic>> updatePassword(
      context, String password, String confirmPassword, String userId) async {
    var result;
    final data = {"password": password, "confirmPassword": confirmPassword};
    notifyListeners();
    Response response;
    // response = await Dio().patch(
    //     "https://fofoapp.herokuapp.com/api/auth/update-password/" + userId,
    //     data: data);
    response = await dioClient.post(context, "auth/update-password" + userId,
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

  Future<Map<String, dynamic>> updateProfile(BuildContext context,
      {required Map user}) async {
    try {
      print(user);
      Response response = await dioClient
          .patch(context, "profile/update-profile-info", data: user);
      print('object');
      print(response.data);
      notifyListeners();

      return {'status': true, 'data': response.data};
    } catch (err) {
      notifyListeners();
      showNotification(context, false, err);
      return {'status': false, 'message': err};
    }
  }
}
