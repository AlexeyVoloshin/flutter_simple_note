import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/color_bloc.dart';
import 'package:hello_flutter/models/note.dart';

class ShowModalBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final void Function(int) onPressed;

  const ShowModalBottomSheet({
    super.key,
    required this.onDelete,
    required this.onEdit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(22),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: 
              Text(
                'Select color',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                          backgroundColor: Color(ColorNote.values[index].color),
                        ),
                        onPressed: () {
                          bloc.add(ColorEvent.values[index]);
                          onPressed(index);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            ListTile(
              leading: Icon(Icons.edit),
              title: Text(
                'Edit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                Navigator.pop(context);
                onEdit();
              },
            ),
            SizedBox(width: 5),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text(
                'Delete',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                Navigator.pop(context);
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
