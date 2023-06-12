import 'package:flutter_noteapp/model/login_info.dart';
import 'package:flutter_noteapp/model/request/login_request.dart';
import 'package:flutter_noteapp/utils/app_variables.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginViewModel extends Model {
  Future<LoginInfo?> login(String username, String password) async {
    var result = await AppVariable.api
        .login(LoginRequest(username: username, password: password));
    if (result.errorCode == 0) {
      return result.data;
    }
    return null;
  }
}
