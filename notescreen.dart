import 'package:flutter/material.dart';
import 'package:flutter_noteapp/model/note_model.dart';
import 'package:flutter_noteapp/ui/noteapp/addNotePage.dart';
import 'package:flutter_noteapp/ui/noteapp/login_screen.dart';
import 'package:flutter_noteapp/ui/noteapp/note_item.dart';
import 'package:flutter_noteapp/ui/noteapp/note_view_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class noteScreen extends StatefulWidget {
  const noteScreen({super.key});

  @override
  State<noteScreen> createState() => _noteScreenState();
}

class _noteScreenState extends State<noteScreen> {
  final _note_view_model = Note_View_Model();
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _note_view_model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Note Screen',
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.cyanAccent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text(
                  'Notification',
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(color: Colors.blueGrey),
              ),
              ListTile(
                leading: Icon(Icons.garage_outlined),
                title: const Text('Deleted'),
              ),
              ListTile(
                leading: Icon(Icons.book_online),
                title: const Text('All Notifications'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const loginScreen()),
                      (route) => false);
                },
                title: const Text('Logout'),
              )
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                'All Notes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              _listNote()
            ],
          ),
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => addNotePage())),
          child: const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xff1977F3),
            child: const Icon(Icons.mode_edit_outline, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

Widget _listNote() => ScopedModelDescendant<Note_View_Model>(
      builder: (BuildContext context, Widget? child, Note_View_Model model) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: model.notes.length,
          itemBuilder: (context, i) {
            return Note_Item(
              note_model: model.notes[i],
              onClick: (noteModel) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const addNotePage()),
                  (route) => false),
              onDelete: (noteModel) => model.delete(noteModel),
            );
          },
        );
      },
    );
