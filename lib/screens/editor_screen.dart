import 'package:flutter/material.dart';

class EditorScreen extends StatefulWidget {
  final String note;
  const EditorScreen({super.key, required this.note});

  @override
  EditorScreenState createState() => EditorScreenState();
}

class EditorScreenState extends State<EditorScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your a note',
                ),
                controller: _controller,
                onSubmitted: (value) => _saveNote(value),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _saveNote(_controller.text),
                  child: Text(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote(value) {
    Navigator.pop(context, value);
  }
}