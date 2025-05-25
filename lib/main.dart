import 'package:flutter/material.dart';
import 'package:hello_flutter/models/note.dart';
import 'package:hello_flutter/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: HomeScreen(),
    ),
  );
}
