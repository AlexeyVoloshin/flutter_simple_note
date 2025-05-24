import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final dynamic noteDetail;

  const DetailScreen({super.key, required this.noteDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            noteDetail,
          ),
        ),
      ),
    );
  }
}
