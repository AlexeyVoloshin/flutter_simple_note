import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final void Function(String) onSubmitted;
  final TextEditingController controller;

  const SearchTextField({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Color(0xFF7C7C7C)),
        hintStyle: TextStyle(color: Color(0xFFABABAB)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFECECEC), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        hintText: 'Search for notes',
      ),
      controller: controller,
      onSubmitted: (value) {
        onSubmitted(value);
      },
      onChanged: (value) => onChanged(value),
    );
  }
}
