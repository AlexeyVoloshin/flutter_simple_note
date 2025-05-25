import 'package:flutter/material.dart';

class ShowModalBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ShowModalBottomSheet({
    super.key,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(22), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit), 
            title: Text(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              'Edit'),
            onTap: () async {
              Navigator.pop(context);
              onEdit();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete'),
            onTap: () async {
              Navigator.pop(context);
              onDelete();
            },
          ),
        ],
      ),
      
      )
       
    );
  }
}
