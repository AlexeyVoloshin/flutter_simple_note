import 'package:flutter/material.dart';
import 'package:hello_flutter/screens/detail_screen.dart';
import 'editor_screen.dart';
import '../services/note_storage.dart';
import '../widgets/show_modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final storNotes = NoteStorageService.loadNotes();
  final Map<dynamic, String> notesMap = {};
  final TextEditingController _controller = TextEditingController();

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Alex.app",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 22.5, left: 22.5),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 18, top: 18),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xFF7C7C7C)),
                  hintStyle: TextStyle(color: Color(0xFFABABAB)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFECECEC), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  hintText: 'Search for notes',
                ),
                controller: _controller,
                onSubmitted: (value) => _searchNotes(value),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(notesMap.length, (index) {
                  final key = notesMap.keys.elementAt(index);
                  final note = notesMap[key]!;
                  return Card(
                    child: ListTile(
                      tileColor: Colors.grey[000063],
                      title: Text(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        note,
                      ),
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ShowModalBottomSheet(
                              onDelete: () async {
                                Navigator.pop(context);
                                setState(() {
                                  notesMap.remove(key);
                                });
                                await NoteStorageService.deleteNote(key);
                              },
                              onEdit: () async {
                                final editedNote = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditorScreen(note: note),
                                  ),
                                );

                                if (editedNote != null &&
                                    editedNote is String) {
                                  setState(() {
                                    notesMap[key] = editedNote.trim();
                                  });
                                  await NoteStorageService.updateNote(
                                    key,
                                    editedNote.trim(),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(noteDetail: note),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 61,
        height: 61,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF1F2937),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () => _addNewNote(),
          child: Icon(Icons.add, color: Colors.white, size: 38),
        ),
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

  void _searchNotes(String value) {}
}
