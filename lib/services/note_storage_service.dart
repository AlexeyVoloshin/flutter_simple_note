import 'package:hello_flutter/models/note.dart';
import 'package:hive/hive.dart';

class NoteStorageService {
  static final Box<Note> _box = Hive.box<Note>('notes');

  /// Завантажити всі нотатки
  static List<Note> loadNotes() {
    return _box.values.toList();
  }

  /// Додати нову нотатку
  static Future<int> addNote(Note note) async {
    return await _box.add(note);
  }

  /// Оновити нотатку (через об'єкт)
  static Future<void> updateNote(Note note, String newTitle, String newDescription) async {
    note.title = newTitle;
    note.description = newDescription;
    await note.save();
  }

  /// Видалити нотатку (через сам об'єкт)
  static Future<void> deleteNote(Note note) async {
    await note.delete();
  }
}