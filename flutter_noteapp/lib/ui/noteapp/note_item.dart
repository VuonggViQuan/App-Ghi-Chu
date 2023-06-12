import 'package:flutter/material.dart';
import 'package:flutter_noteapp/model/note_model.dart';

class Note_Item extends StatelessWidget {
  const Note_Item(
      {super.key,
      required this.note_model,
      required this.onClick,
      required this.onDelete});
  final Note_Model note_model;
  final Function(Note_Model note_model) onClick;
  final Function(Note_Model note_model) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Text(
            '${note_model.title}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () => onClick(note_model),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          child: Text(
            '${note_model.description}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          onTap: () => onClick(note_model),
        ),
        SizedBox(
          height: 5,
        ),
        IconButton(
          onPressed: onDelete == null ? null : () => onDelete(note_model),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
