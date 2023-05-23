import 'package:flutter/material.dart';
import 'package:flutter_noteapp/ui/noteapp/addNotePage.dart';
import 'package:flutter_noteapp/ui/noteapp/login_screen.dart';

class noteScreen extends StatefulWidget {
  const noteScreen({super.key});

  @override
  State<noteScreen> createState() => _noteScreenState();
}

class _noteScreenState extends State<noteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'All Notes',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'No note',
              style: TextStyle(color: Colors.blueGrey),
            )
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
    );
  }
}
