import 'package:flutter/material.dart';
class deleted_screen extends StatefulWidget {
  const deleted_screen({super.key});

  @override
  State<deleted_screen> createState() => _deleted_screenState();
}

class _deleted_screenState extends State<deleted_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deleted Item')
      ),
     
    );
  }
}