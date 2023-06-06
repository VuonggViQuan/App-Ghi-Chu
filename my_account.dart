import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noteapp/ui/noteapp/auth.dart';

class myAccountScreen extends StatefulWidget {
  const myAccountScreen({super.key});

  @override
  State<myAccountScreen> createState() => _myAccountScreenState();
}

class _myAccountScreenState extends State<myAccountScreen> {
  final User? user = Auth().currentUser;
  Widget userUid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person),
            Text(user?.email ?? 'User email'),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account')),
      body: Container(
        child: Center(
          child: userUid(),
        ),
      ),
    );
  }
}
