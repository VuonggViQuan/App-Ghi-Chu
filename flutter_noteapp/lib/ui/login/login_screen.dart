import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_noteapp/ui/login/login_view_mode.dart';
import 'package:flutter_noteapp/ui/major/major_screen.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';
import 'package:flutter_noteapp/utils/app_variables.dart';
import 'package:flutter_noteapp/utils/prefs.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final loginViewModel = LoginViewModel();
    void loginAction(var context, LoginViewModel model) async {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        var formValue = _formKey.currentState!.value;
        final username = formValue['username'].toString();
        final password = formValue['password'].toString();
        final result = await model.login(username, password);

        if (result == null) {
          AppVariable.userInfo = result;
          Prefs.setUserName(username);
          Prefs.setPassword(password);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => noteScreen()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Wrong username or password ')));
        }
      }
    }

    return ScopedModel(
        model: loginViewModel,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text('Login'),
                        FormBuilderTextField(
                          name: 'username',
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username'),
                          validator: FormBuilderValidators.required(),
                          keyboardType: TextInputType.text,
                        ),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                          validator: FormBuilderValidators.required(),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => loginAction(context, LoginViewModel()),
                    child: Text('Login'))
              ],
            ),
          ),
        ));
  }
}
