import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hava/models/know_model.dart';
import 'package:hava/screens/note/note_dialog_view.dart';
import 'package:hava/themes/styles.dart';

class TheoryView extends StatelessWidget {
  final KnowModel model;

  const TheoryView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lý thuyết'),
        actions: [_buildIconImg(context)],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: Styles.cusText(color: Styles.colorB2, size: 16),
            ),
            Html(
              data: model.content,
              style: {
                "td": Style(
                  padding: const EdgeInsets.all(10),
                  border: Border.all(color: Colors.black),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconImg(context) {
    return FlatButton(
      shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      splashColor: Colors.white12,
      onPressed: () => showDialogNote(context),
      child: Image.asset('assets/icons/ic_note.png', width: 24, height: 24),
    );
  }

  void showDialogNote(context) {
    showDialog(context: context, builder: (context) => const NoteDialogView());
  }
}
