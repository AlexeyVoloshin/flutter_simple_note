import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // init Hive
  await Hive.openBox<String>('notes'); // Open box for notes

  runApp(MaterialApp(home: HomeScreen()));
}




