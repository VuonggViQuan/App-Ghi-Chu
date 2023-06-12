import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_noteapp/model/loginModel.dart';
import 'package:flutter_noteapp/model/login_info.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  loginModel login = loginModel();

  bool _hidepassword = true;
  IconData icon = Icons.visibility;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Login Note',
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      controller: usernameController,
                      name: 'username',
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(70),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormBuilderTextField(
                      controller: passwordController,
                      name: "password",
                      obscureText: _hidepassword,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _hidepassword = !_hidepassword;
                            icon = _hidepassword
                                ? Icons.visibility
                                : Icons.visibility_off;
                          }),
                          icon: Icon(icon),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    final curState = _formKey.currentState!;
                    var message = "";
                    curState.save();
                    if (curState.validate()) {
                      message = "Login success";
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const noteScreen()),
                          (route) => false);
                    } else {
                      message = "Validate failed";
                    }
                    final snackBar = SnackBar(content: Text(message));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Login'))
            ],
          ),
        ));
  }
}
