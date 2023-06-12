import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noteapp/model/note_model.dart';
import 'package:flutter_noteapp/ui/noteapp/note_view_viewmodel.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';

class addNotePage extends StatefulWidget {
  const addNotePage({super.key});

  @override
  State<addNotePage> createState() => _addNotePageState();
}

class _addNotePageState extends State<addNotePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DatabaseReference dbRef;
  // Note_Model noteModel = Note_Model.withArgs(id: 0, title: '', description: '');
  // Note_View_Model model = Note_View_Model();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Notes');
  }

  @override
  Widget build(BuildContext context) {
    // _titleController.text = noteModel.title;
    // _descriptionController.text = noteModel.description;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add Note',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Center(
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
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // onTap: () {
            //   final snackbar = SnackBar(
            //     content: const Text('Save Completed !'),
            //     action: SnackBarAction(
            //       label: 'Undo',
            //       onPressed: () {},
            //     ),
            //   );
            //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
            // },
            onTap: () {
              // noteModel ??= Note_Model(title: '', description: '');

              // Navigator.pop(context);
              // noteModel.title = _titleController.text.trim();
              // noteModel.description = _descriptionController.text.trim();
              // model.save(noteModel);
              Map<String, String> notes = {
                'title': _titleController.text,
                'description': _descriptionController.text
              };
              dbRef.push().set(notes);
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Save sucess!')));
            },
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Title', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 35,
          ),
          TextField(
            controller: _descriptionController,
            maxLines: 5,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Write a note',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
