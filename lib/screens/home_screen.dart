import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hello_flutter/color_bloc.dart';
import 'package:hello_flutter/screens/detail_screen.dart';
import 'package:hello_flutter/widgets/card_note.dart';
import '../widgets/search_text_field.dart';
import 'editor_screen.dart';
import '../services/note_storage_service.dart';
import '../widgets/show_modal_bottom_sheet.dart';
import 'package:hello_flutter/models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Note> allNotesList = [];
  List<Note> filteredNotesList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    allNotesList = NoteStorageService.loadNotes();
    filteredNotesList = List.from(allNotesList);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void refreshNotes() {
    setState(() {
      allNotesList = NoteStorageService.loadNotes();
      filteredNotesList = List.from(allNotesList);
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
              child: SearchTextField(
                onChanged: (String value) {
                  final query = value.trim().toLowerCase();
                  filterNotes(query);
                },
                onSubmitted: (value) {
                  final query = value.trim().toLowerCase();
                  if (filteredNotesList.isEmpty || query.isEmpty) {
                    refreshNotes();
                  }
                  _searchController.text = '';
                },
                controller: _searchController,
              ),
            ),
            Expanded(
              child: filteredNotesList.isEmpty
                  ? Center(child: Text('Notes is empty'))
                  : MasonryGridView.builder(
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemCount: filteredNotesList.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotesList[index];

                        return CardNote(
                          note: note,
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: BlocProvider.of<ColorBloc>(context),
                                  child: ShowModalBottomSheet(
                                    onDelete: () => _deleteNote(note),
                                    onEdit: () => _editNote(note), 
                                    onPressed: (indexColor) => _changeColor(note, indexColor),
                                  ),
                                );
                              },
                            );
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(noteDetail: note),
                              ),
                            );
                          },
                        );
                      },
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
          onPressed: _addNewNote,
          child: Icon(Icons.add, color: Colors.white, size: 38),
        ),
      ),
    );
  }

  Future<void> _changeColor(Note note, int index) async {
    note.colorValue = ColorNote.values[index].color;
    await NoteStorageService.updateNote(note, note.title, note.description, note.colorValue);
    refreshNotes();
  }

  Future<void> _deleteNote(Note note) async {
    await NoteStorageService.deleteNote(note);
    refreshNotes();
  }

  Future<void> _editNote(Note note) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorScreen(
          note: note,
          onSave: (String title, String description) async {
            await NoteStorageService.updateNote(note, title, description, note.colorValue);
            setState(() {
              refreshNotes();
            });
          },
        ),
      ),
    );
  }

  Future<void> _addNewNote() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorScreen(
          note: null,
          onSave: (String title, String description) {
            final newNote = Note(title: title, description: description);
            newNote.colorValue = ColorNote.colorDefault.color;
            NoteStorageService.addNote(newNote);
            setState(() {
              refreshNotes();
            });
          },
        ),
      ),
    );
  }

  void filterNotes(String value) {
    final query = value.toLowerCase();
    final filteredNotes = allNotesList.where(
      (note) => note.title.toLowerCase().contains(query),
    );
    setState(() {
      filteredNotesList = List.from(filteredNotes);
    });
  }
}
