import 'package:flutter/material.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
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
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: _hidepassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidepassword = !_hidepassword;
                        icon = _hidepassword
                            ? Icons.visibility
                            : Icons.visibility_off;
                      });
                    },
                    icon: Icon(icon),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const noteScreen()),
                        (route) => false);
                  },
                  child: const Text('Login'))
            ],
          ),
        ));
  }
}
