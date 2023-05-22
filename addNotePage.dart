import 'package:flutter/material.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';

class addNotePage extends StatefulWidget {
  const addNotePage({super.key});

  @override
  State<addNotePage> createState() => _addNotePageState();
}

class _addNotePageState extends State<addNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Add Note',
          style: TextStyle(color: Colors.lightBlueAccent),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              final snackbar = SnackBar(
                content: const Text('Save Completed !'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            },
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Title', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 35,
          ),
          TextField(
            maxLines: 5,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Write a note',
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}
