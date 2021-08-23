import 'package:flutter/material.dart';
import 'package:hava/base/view_all.dart';
import 'package:hava/models/note_model.dart';

class ItemNoteView extends StatelessWidget {
  final Color color;
  final Function onDelete, onUpdate;
  final NoteModel model;

  const ItemNoteView(
      {Key? key,
      required this.color,
      required this.onDelete,
      required this.onUpdate,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onUpdate(model),
      child: Container(
        height: 50,
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: VAll.boxShadow(),
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                model.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => onDelete(model.id),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
