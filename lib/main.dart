import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/blocs/color_bloc.dart';
import 'package:hello_flutter/models/note.dart';
import 'package:hello_flutter/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');

  runApp(
    BlocProvider<ColorBloc>(
      create: (_) => ColorBloc(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Roboto'),
        home: HomeScreen(),
      ),
      )
  );
}
