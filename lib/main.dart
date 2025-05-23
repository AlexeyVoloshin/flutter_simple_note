import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // init Hive
  await Hive.openBox<String>('notes'); // Open box for notes

  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<String> notesStor = Hive.box<String>('notes');
  final Map<dynamic, String> notesMap = {};

  @override
  void initState() {
    super.initState();
    notesStor.toMap().forEach((key, value) {
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
                      notesMap[key] = editedNote;
                    });
                    notesStor.put(key, editedNote);
                  }
                },
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      notesMap.remove(key);
                    });
                    notesStor.delete(key);
                  },
                  icon: Icon(color: Colors.red, Icons.delete),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewNote(),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _createNewNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditorScreen(note: '')),
    );

    if (newNote != null && newNote != '' && newNote is String) {
      final newKey = await notesStor.add(newNote);

      setState(() {
        notesMap[newKey] = newNote;
      });
    }
  }
}

class EditorScreen extends StatefulWidget {
  final String note;
  const EditorScreen({super.key, required this.note});

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editor notes')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your a note',
                ),
                controller: _controller,
                onSubmitted: (value) => _saveNote(value),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveNote(_controller.text),
                  child: Text(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote(value) {
    Navigator.pop(context, value);
  }
}
