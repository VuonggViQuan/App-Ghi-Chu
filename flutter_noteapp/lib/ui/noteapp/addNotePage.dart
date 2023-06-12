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
  Note_Model noteModel = Note_Model.withArgs(id: 0, title: '', description: '');
  Note_View_Model model = Note_View_Model();

  @override
  Widget build(BuildContext context) {
    _titleController.text = noteModel.title;
    _descriptionController.text = noteModel.description;
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
              child: const Text(
                'Save',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.lightBlueAccent,
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

              Navigator.pop(context);
              noteModel.title = _titleController.text.trim();
              noteModel.description = _descriptionController.text.trim();
              model.save(noteModel);
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
          )
        ],
      ),
    );
  }
}
