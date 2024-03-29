import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/auth_service/auth_provider.dart';
import '../core/widgets/notification.dart';
import '../features/auth/presentation/login.dart';

class DioClient extends ChangeNotifier {
// dio instance
  final Dio _dio;
  final auth = AuthProvider();
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json;
    // ..options.headers = {"Authorization": "Bearer $token"};
  }

  Future<Response> get(
    context,
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    print('get into');
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      print('get error');
      print(e);
      EasyLoading.dismiss();

      if (e.response?.statusCode == 401) {
        print('llodd');
        logout(context);
        return e.response!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        showNotification(context, false, errorMessage);
        throw errorMessage;
      }

      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // if (e.response?.statusCode == 401) {
      //   logout(context);
      // }
      // showNotification(context, false, errorMessage);
      // throw errorMessage;
    }
  }

  Future<void> logout(context) async {
    // await auth.init();
    // auth.logOut(context);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
    _preferences.setBool("skipOnboard", true);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }

  Future<Response> post(
    context,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      EasyLoading.dismiss();
      // print(e.requestOptions.uri);
      print('post error');
      print(e);

      if (e.response?.statusCode == 401) {
        print('llodd');
        logout(context);
        return e.response!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
    }
  }

  Future<Response> put(
    context,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      EasyLoading.dismiss();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> patch(
    context,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      EasyLoading.dismiss();
      print('patch error');
      print(e);
      final errorMessage = DioExceptions.fromDioError(e).toString();
      if (e.response?.statusCode == 401) {
        logout(context);
        return e.response!;
      } else {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        throw errorMessage;
      }
      // throw errorMessage;
    }
  }

  Future<dynamic> delete(
    context,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioError catch (e) {
      EasyLoading.dismiss();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl =
      "https://calm-lime-goldfish-tutu.cyclic.app/api/";

  // receiveTimeout
  static const int receiveTimeout = 30000;

  // connectTimeout
  static const int connectionTimeout = 30000;
}

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with server";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with server";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    print('api errors');
    print(error);
    switch (statusCode) {
      case 400:
        return error['message'];
      case 401:
        return error['message'];
      case 403:
        return error['message'];
      case 404:
        return error['message'];
      case 409:
        return error['message'];
      case 422:
        return error['error'];
      case 500:
        print('hee 500');
        print(error.runtimeType);
        print(jsonDecode(error));
        var error2 = jsonDecode(error);
        print(error2['message']);
        if (error2.containsKey('message')) {
          return error2['message'];
        } else {
          return "Error, Please try again";
        }

      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
