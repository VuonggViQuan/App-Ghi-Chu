import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginModel {
  String userName = "";
  String password = "";

  loginModel() {}
  loginModel.withArgs({required this.userName, required this.password}) {
  }
  void setUserName(String username) {
    this.userName = username;
  }
  String getUserName() {
    return this.userName;
  }
  void setPassword(String password) {
    this.password = password;
  }
  String getPassword() {
    return this.password;
  }
}