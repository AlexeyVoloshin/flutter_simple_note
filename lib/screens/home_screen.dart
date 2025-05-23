import 'package:flutter/material.dart';
import '../services/note_storage.dart';
import 'editor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final storNotes = NoteStorageService.loadNotes();
  final Map<dynamic, String> notesMap = {};

  @override
  void initState() {
    super.initState();
    storNotes.forEach((key, value) {
      notesMap[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My notes")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: notesMap.length,
          itemBuilder: (context, index) {
            final key = notesMap.keys.elementAt(index);
            final note = notesMap[key]!;
            return Card(
              child: ListTile(
                tileColor: Colors.grey[000063],
                title: Text(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  note,
                ),
                onTap: () async {
                  final editedNote = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditorScreen(note: note),
                    ),
                  );

                  if (editedNote != null && editedNote is String) {
                    setState(() {
                      notesMap[key] = editedNote.trim();
                    });
                    await NoteStorageService.updateNote(key, editedNote.trim());
                  }
                },
                trailing: IconButton(
                  onPressed: () async {
                    setState(() {
                      notesMap.remove(key);
                    });
                    await NoteStorageService.deleteNote(key);
                  },
                  icon: Icon(color: Colors.red, Icons.delete),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewNote(),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addNewNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditorScreen(note: '')),
    );

    if (newNote != null && newNote != '' && newNote is String) {
      final newKey = await NoteStorageService.addNote(newNote.trim());

      setState(() {
        notesMap[newKey] = newNote.trim();
      });
    }
  }
}