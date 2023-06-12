import 'package:flutter/material.dart';
import 'package:flutter_noteapp/model/major.dart';

class MajorItem extends StatelessWidget {
  const MajorItem(
      {super.key,
      required this.major,
      required this.onClick,
      required this.onDelete});
  final Major major;
  final Function(Major major) onClick;
  final Function(Major major) onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          InkWell(
            child: Text('${major.name}'),
            onTap: () => onClick(major),
          ),
          Spacer(),
          IconButton(
              onPressed: onDelete == null ? null : () => onDelete(major),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
