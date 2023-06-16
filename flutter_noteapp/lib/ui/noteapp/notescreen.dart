import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_noteapp/model/note_model.dart';
import 'package:flutter_noteapp/ui/noteapp/addNotePage.dart';
import 'package:flutter_noteapp/ui/noteapp/auth.dart';
import 'package:flutter_noteapp/ui/noteapp/login_register_page.dart';

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
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Notes');
  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => loginRegisterPage()),
        (route) => false);
  }

// Thành phần Widget tạo ra list item sau đó dán widget này vào body ở phía dưới
  Widget listItem({required Map note}) {
    return GridView.count(
        childAspectRatio: (1 / 0.4),
        crossAxisSpacing: 5,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 3)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Text(
                        note['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(note['description'],
                          style: TextStyle(
                            fontSize: 20,
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
    return Scaffold(
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => loginRegisterPage()),
                    (route) => false);
              },
              title: const Text('Logout'),
            )
          ],
        ),
      ),
      body: Container(
        child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map note = snapshot.value as Map;
              note['key'] = snapshot.key;

              return listItem(note: note);
            }),
      ),
      // 1 dạng button chuyển trang
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
    );
  }
}
