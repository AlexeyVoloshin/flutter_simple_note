import 'package:flutter/material.dart';

class FormNote extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController titleController;

  final TextEditingController descriptionController;

  final VoidCallback submitForm;

  const FormNote({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.submitForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter a title';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: TextFormField(
              controller: descriptionController,
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter a description';
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 24),
          ElevatedButton(onPressed: submitForm, child: Text('Save')),
        ],
      ),
    );
  }
}
