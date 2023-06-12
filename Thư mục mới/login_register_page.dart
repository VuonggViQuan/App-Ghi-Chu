import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_noteapp/ui/noteapp/auth.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';

class loginRegisterPage extends StatefulWidget {
  const loginRegisterPage({super.key});

  @override
  State<loginRegisterPage> createState() => _loginRegisterPageState();
}

class _loginRegisterPageState extends State<loginRegisterPage> {
  String? message = "";
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> sigInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => noteScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        message = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      message = e.message;
    }
  }

  Widget entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? sigInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(!isLogin ? 'Login' : 'Register'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login Page' : 'Register Page'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            entryField('Email', _controllerEmail),
            entryField('Password', _controllerPassword),
            submitButton(),
            loginOrRegisterButton()
          ],
        ),
      ),
    );
  }
}
