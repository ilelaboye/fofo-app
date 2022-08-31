import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fofo_app/core/utils/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model/otp_model.dart';
import '../../models/user_model/user_model.dart';

Future<void> setFullNameData(fullNameValue) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('fullname', fullNameValue);
}

Future<void> setFieldData(fieldValue) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('field', fieldValue);
}

Future<void> setTokenData(tokenValue) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('tokendata', tokenValue);
  print(tokenValue);
}

Future<void> setUserId(userValue) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userdata', userValue);
}

class SignUpService extends ISignUp {
  @override
  Future<UserModel?> signUp(String fullname, String email, String phonenumber,
      String field, String password, BuildContext context) async {
    if (fullname.isNotEmpty &&
        email.isNotEmpty &&
        phonenumber.isNotEmpty &&
        field.isNotEmpty &&
        password.isNotEmpty) {
      const api = "https://fofoapp.herokuapp.com/api/auth/register";
      final data = {
        "fullname": fullname,
        "email": email,
        "phonenumber": phonenumber,
        "field": field,
        "password": password
      };
      setFullNameData(data["fullname"]);
      setFieldData(data["field"]);
      final dio = Dio();
      Response response;
      response = await dio.post(api, data: data);
      print(response);
      if (response.statusCode == 200) {
        final body = response.data;
        print(response.data);
        setTokenData(response.data["accessToken"]);
        setUserId(body['userId']);
        print(body);
        return UserModel(email: email);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.statusMessage.toString())));
      }
    }
    // notifyListeners();
  }
}

class LoginService extends ILogin {
  @override
  Future<UserModel?> login(
      String email, String password, BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      const api = "https://fofoapp.herokuapp.com/api/auth/login";
      final data = {"email": email, "password": password};
      final dio = Dio();
      Response response;
      response = await dio.post(api, data: data);
      if (response.statusCode == 200) {
        final body = response.data;
        setTokenData(body['token']);
        return UserModel(email: email);
      } else {
        return null;
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('blank field not allowed')));
    }
  }
}

class VerifyOtpService extends IVerifyOtp {
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

class ResendOtpService extends IResendOtp {
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
