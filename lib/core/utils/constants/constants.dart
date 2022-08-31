import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/models/profile/user_profile/user_profile.dart';
import 'package:fofo_app/models/user_model/otp_model.dart';
import 'package:fofo_app/models/user_model/reset_password.dart';
import 'package:fofo_app/models/user_model/user_model.dart';

abstract class ISignUp {
  Future<UserModel?> signUp(String fullname, String email, String phonenumber,
      String field, String password, BuildContext context) async {
    const api = "https://fofoapp.herokuapp.com/api/auth/register";
    final data = {
      "fullname": fullname,
      "email": email,
      "phonenumber": phonenumber,
      "field": field,
      "password": password
    };
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      return UserModel(email: email);
    } else {
      return null;
    }
  }
}

abstract class ILogin {
  Future<UserModel?> login(
      String email, String password, BuildContext context) async {
    const api = "https://fofoapp.herokuapp.com/api/auth/login";
    final data = {"email": email, "password": password};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      return UserModel(email: email);
    } else {
      return null;
    }
  }
}

abstract class IVerifyOtp {
  Future<OtpModel?> otpVerify(String otp) async {
    const api = "https://fofoapp.herokuapp.com/api/auth/verifyotp";
    final data = {"otp": otp};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      return OtpModel(otp: otp);
    } else {
      return null;
    }
  }
}

abstract class IResendOtp {
  Future<UserModel?> resendOtp(String email) async {
    const api = "https://fofoapp.herokuapp.com/api/auth/reset-password";
    final data = {"email": email};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      return UserModel(email: email);
    } else {
      return null;
    }
  }
}

abstract class GetUserProfile {
  Future<UserProfile?> getUserProfile();
}
