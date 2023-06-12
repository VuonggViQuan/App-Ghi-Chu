import 'package:dio/dio.dart';
import 'package:flutter_noteapp/utils/app_variables.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (AppVariable.userInfo != null) {
      options.headers['Authorization'] =
          'Bearer ${AppVariable.userInfo!.token}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }

  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
