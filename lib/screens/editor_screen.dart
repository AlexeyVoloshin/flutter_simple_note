import 'package:flutter/material.dart';
import 'package:hello_flutter/models/note.dart';
import 'package:hello_flutter/widgets/note_form.dart';

class EditorScreen extends StatefulWidget {
  final Note? note;
  final Function(String title, String description) onSave;

  const EditorScreen({super.key,  required this.note, required this.onSave});

  @override
  EditorScreenState createState() => EditorScreenState();
}

class EditorScreenState extends State<EditorScreen> {
  final _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _descriptionController = TextEditingController(text: widget.note?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        _titleController.text.trim(),
        _descriptionController.text.trim(),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: NoteForm(
          formKey: _formKey, 
          titleController: _titleController, 
          descriptionController: _descriptionController, 
          submitForm: _submitForm)
      ),
    );
  }
}