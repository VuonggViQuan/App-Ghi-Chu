import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_noteapp/model/note_model.dart';
import 'package:flutter_noteapp/ui/noteapp/addNotePage.dart';
import 'package:flutter_noteapp/ui/noteapp/auth.dart';
import 'package:flutter_noteapp/ui/noteapp/login_register_page.dart';
import 'package:flutter_noteapp/ui/noteapp/login_screen.dart';
import 'package:flutter_noteapp/ui/noteapp/my_account.dart';
// import 'package:flutter_noteapp/ui/noteapp/note_item.dart';
import 'package:flutter_noteapp/ui/noteapp/note_view_viewmodel.dart';
import 'package:flutter_noteapp/ui/noteapp/updateNote.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class noteScreen extends StatefulWidget {
  const noteScreen({super.key});

  @override
  State<noteScreen> createState() => _noteScreenState();
}

class _noteScreenState extends State<noteScreen> {
  final _note_view_model = Note_View_Model();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Notes');
  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => loginRegisterPage()),
        (route) => false);
  }

  Widget listItem({required Map note}) {
    return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 8)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Text(
                        note['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(note['description'],
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                updateNote(noteKey: note['key'])),
                        (route) => false);
                  },
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ref.child(note['key']).remove();
                    },
                    icon: const Icon(Icons.delete, color: Colors.red))
              ],
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance.ref().child('Notes');
    return ScopedModel(
      model: _note_view_model,
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Note Screen',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
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
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('My account'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => myAccountScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Logout!')));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => loginRegisterPage()));
                },
                title: const Text('Logout'),
              )
            ],
          ),
        ),
        body: Container(
          
          // child: Column(
          //   children: [
          //     const Text(
          //       'All Notes',
          //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //     ),
          //     Text('${_note_view_model.notes.length} notes'),

          // GridView.count(
          //   physics: const NeverScrollableScrollPhysics(),
          //   crossAxisCount: 2,
          //   shrinkWrap: true,
          //   children: [
          //     Container(
          //         padding:
          //             EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(20),
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //                 color: Colors.black.withOpacity(0.4),
          //                 spreadRadius: 1,
          //                 blurRadius: 8)
          //           ],
          //         ),
          //         child: Container(
          //           margin: EdgeInsets.all(10),
          //           child: _listNote(),
          //         ))
          //   ],
          // )

          // ],
          // ),
          child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map note = snapshot.value as Map;
                note['key'] = snapshot.key;

                return listItem(note: note);
              }),
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
            return GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                // Container(
                //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.black.withOpacity(0.4),
                //             spreadRadius: 1,
                //             blurRadius: 8)
                //       ],
                //     ),
                //     child: Container(
                //       // margin: EdgeInsets.all(10),

                //       child: Note_Item(
                //         note_model: model.notes[i],
                //         onClick: (noteModel) => Navigator.pushAndRemoveUntil(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const addNotePage()),
                //             (route) => false),
                //         onDelete: (noteModel) => model.delete(noteModel),
                //       ),
                //     ),
                //     ),

                // child: StreamBuilder(
                //   stream: FirebaseFirestore.instance
                //       .collection("note")
                //       .snapshots(),
                //   builder:
                //       (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                //     if (!streamSnapshot.hasData) {
                //       return Center(
                //         child: const CircularProgressIndicator(),
                //       );
                //     }
                //     return ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       physics: BouncingScrollPhysics(),
                //       itemCount: streamSnapshot.data!.docs.length,
                //       itemBuilder: (ctx, index) {
                //         return Note_Item(
                //           note_title: streamSnapshot.data!.docs[index]
                //               ["note_title"],
                //           note_description: streamSnapshot.data!.docs[index]
                //               ["note_description"],
                //         );
                //       },
                //     );
                //   },
                // ),
                // ),
              ],
            );
          },
        );
      },
    );
