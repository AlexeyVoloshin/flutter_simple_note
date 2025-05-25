import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

enum ColorNote {
  lavender(color: Color(0xFFD9E8FC), title: 'Lavender'),
  khaki(color: Color(0xFFFDE99D), title: 'Khaki'),
  mistyRose(color: Color(0xFFFFD8F4), title: 'Misty rose'),
  antiqueWhite(color: Color(0xFFFFEADD), title: 'Antique white'),
  paleTurquoise(color: Color(0xFFB0E9CA), title: 'Pale turquoise');

  const ColorNote({ required this.color, required this.title });

  final Color? color;
  final String title;

}

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  ColorNote? color;

  Note({required this.title, required this.description, this.color});
  
}