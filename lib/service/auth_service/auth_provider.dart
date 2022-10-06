// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/core/presentation/app/app_scaffold.dart';
import 'package:fofo_app/models/user_model/otp_model.dart';
import 'package:fofo_app/models/user_model/user_model.dart';
import 'package:fofo_app/service/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/profile/user_profile/user_profile.dart';
import '../../models/user_model/reset_password.dart';
import '../user_provider/user_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

const _STORE_ACCESS_TOKEN_KEY = "_store_access_token_key";
const _STORE_REFRESH_TOKEN_KEY = "_sotore_acccess_refresh_token_key";
const _STORE_USER_KEY = "_sotore_user_key";

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  UserModel? authUser;
  UserProfile? userProfile;
  String? token;

  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    token = getToken();
    userProfile = getUser();
    getRefreshToken();
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

  Future<UserProfile?> getUserProfile(String _token) async {
    const api = "https://fofoapp.herokuapp.com/api/profile";

    final response = await Dio().get(api,
        options: Options(
            responseType: ResponseType.json,
            headers: {"Authorization": "Bearer $_token"}));
    if (response.statusCode != 200) {
      return null;
    }
    return UserProfile.fromMap(response.data[0]);
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      _loggedInStatus = Status.Authenticating;
      notifyListeners();

      const api = "https://fofoapp.herokuapp.com/api/auth/login";

      Response response =
          await Dio().post(api, data: {'email': email, 'password': password});

      final isLoginSuccessful = response.statusCode == 200;

      _loggedInStatus =
          isLoginSuccessful ? Status.LoggedIn : Status.NotLoggedIn;

      if (isLoginSuccessful == false) {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed Login")));
        debugPrint(response.data);
        return;
      }

      userProfile = await getUserProfile(response.data['accessToken']);
      token = response.data['accessToken'];
      if (userProfile == null) {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        return;
      }
      ;

      setUser(userProfile!);
      setToken(response.data['accessToken']);
      setRefreshToken(response.data['refreshToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AppScaffoldPage()),
          (route) => false);

      notifyListeners();
    } catch (err) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
    }
  }

  // Future<Map<String, dynamic>>logOut()async{
  //   await 
  // }

  Future<Map<String, dynamic>> register(
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
    const api = "https://fofoapp.herokuapp.com/api/auth/register";
    _registeredInStatus = Status.Registering;
    notifyListeners();
    Response response;
    print('about to register');
    response = await Dio().post(api, data: registrationData);
    final body = response.data;
    print(body);
    if (response.statusCode != 200) {
      return {'status': false, 'message': 'Registration failed', 'data': body};
    }

    authUser = UserModel.fromMap(body);
    authUser = authUser!.copyWith(
        fullname: fullname,
        email: email,
        phonenumber: phonenumber,
        field: field,
        password: password);
    // UserPreferences().saveUser(authUser!);
    notifyListeners();
    // print(UserPreferences().saveUser(authUser!));
    return {
      'status': true,
      'message': 'Successfully registered',
      'data': authUser
    };
  }

  Future<Map<String, dynamic>> verifyOtp(String otp, String token) async {
    var result;
    const api = "https://fofoapp.herokuapp.com/api/auth/verifyotp";
    final bearerToken = token;
    final Map<String, dynamic> otpData = {"otp": otp};
    notifyListeners();
    Response response;
    response = await Dio().post(api,
        data: otpData,
        options: Options(
            responseType: ResponseType.json,
            headers: {"Authorization": "Bearer $bearerToken"}));
    if (response.statusCode == 200) {
      final body = response.data;
      OtpModel otpCode = OtpModel.fromMap(body);
      notifyListeners();
      result = {'status': true, 'message': 'Successful', 'user': otpCode};
    } else {
      notifyListeners();
      result = {'status': false, 'message': response.data['error']};
    }
    return result;
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
        print(response.data);
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
