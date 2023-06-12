import 'package:dio/dio.dart';
import 'package:flutter_noteapp/model/base_result.dart';
import 'package:flutter_noteapp/model/login_info.dart';
import 'package:flutter_noteapp/model/major.dart';
import 'package:flutter_noteapp/model/request/login_request.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://restfulapi.dnd-group.net/api/")
abstract class ApiClient {
  factory ApiClient.withArgs(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/majors')
  Future<BaseResult<List<Major>>> getMajors();
  @GET('/majors/{id}')
  Future<BaseResult<Major>> getMajor(@Path() int id);
  @POST('/majors')
  Future<BaseResult<Major>> addMajor(@Body() Major major);
  @PUT('/majors/{id}')
  Future<BaseResult<Major>> updateMajor(@Path() int id, @Body() Major major);
  @DELETE('/majors/{id}')
  Future<BaseResult> deleteMajor(@Path() int id);
  @POST('/login')
  Future<BaseResult<LoginInfo>> login(@Body() LoginRequest req);

 
}
