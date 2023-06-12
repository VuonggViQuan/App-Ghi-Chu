import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noteapp/ui/noteapp/notescreen.dart';

class updateNote extends StatefulWidget {
  const updateNote({super.key, required this.noteKey});
  final String noteKey;
  @override
  State<updateNote> createState() => _updateNoteState();
}

class _updateNoteState extends State<updateNote> {
  final _titleEditController = TextEditingController();
  final _descriptionEditController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Notes');
    getNoteData();
  }

  void getNoteData() async {
    DataSnapshot snapshot = await dbRef.child(widget.noteKey).get();

    Map note = snapshot.value as Map;

    _titleEditController.text = note['title'];
    _descriptionEditController.text = note['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Value',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          child: Column(
            children: [
              TextField(
                controller: _titleEditController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Edit title',
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _descriptionEditController,
                maxLines: 4,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Edit description',
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> notes = {
                    'title': _titleEditController.text,
                    'description': _descriptionEditController.text
                  };
                  dbRef.child(widget.noteKey).update(notes).then((value) => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => noteScreen()),
                          (route) => false,
                        )
                      });
                },
                child: Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              )
            ],
          )),
    );
  }
}
