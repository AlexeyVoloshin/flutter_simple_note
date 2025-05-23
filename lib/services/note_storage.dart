import 'package:hive/hive.dart';

class NoteStorageService {
  static final Box<String> _box = Hive.box<String>('notes');

  /// Load all the notes to the Map
  static Map<dynamic, String> loadNotes() {
    return _box.toMap();
  }

  /// Add the new note
  static Future<int> addNote(String note) async {
    return await _box.add(note);
  }

  /// Update the current note of the key
  static Future<void> updateNote(dynamic key, String updatedNote) async {
    await _box.put(key, updatedNote);
  }
  /// Delete the note of the key
  static Future<void> deleteNote(dynamic key) async {
    await _box.delete(key);
  }
}