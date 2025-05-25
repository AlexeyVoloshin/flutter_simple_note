import 'package:hive/hive.dart';

part 'note.g.dart';

enum ColorNote {
  lavender(color: 0xFFD9E8FC, title: 'Lavender'),
  khaki(color: 0xFFFDE99D, title: 'Khaki'),
  mistyRose(color: 0xFFFFD8F4, title: 'Misty rose'),
  antiqueWhite(color: 0xFFFFEADD, title: 'Antique white'),
  paleTurquoise(color: 0xFFB0E9CA, title: 'Pale turquoise'),
  colorDefault(color: 0xFFECECEC, title: 'Color default');

  const ColorNote({ required this.color, required this.title });

  final int color;
  final String title;

}

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int colorValue;

  Note({required this.title, required this.description, this.colorValue = 0xFFFFEADD});
  
}