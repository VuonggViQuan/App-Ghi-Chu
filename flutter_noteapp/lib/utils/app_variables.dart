import 'package:dio/dio.dart';
import 'package:flutter_noteapp/api/api.dart';
import 'package:flutter_noteapp/api/api_interceptor.dart';
import 'package:flutter_noteapp/model/login_info.dart';

class AppVariable {
  static LoginInfo? userInfo;
  static late ApiClient api;

  static void inIt() {
    final dio = Dio();
    dio.options.contentType = 'application/json;charset=utf-8';
    dio.interceptors.add(ApiInterceptor());
    api = ApiClient.withArgs(dio);
  }
}
