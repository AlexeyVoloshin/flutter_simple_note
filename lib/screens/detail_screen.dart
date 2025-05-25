import 'package:flutter/material.dart';
import 'package:hello_flutter/models/note.dart';

class DetailScreen extends StatelessWidget {
  final Note noteDetail;

  const DetailScreen({super.key, required this.noteDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                noteDetail.title,
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                style: TextStyle(color: Colors.black, fontSize: 18),
                noteDetail.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
