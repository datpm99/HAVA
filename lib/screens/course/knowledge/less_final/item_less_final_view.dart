import 'package:flutter/material.dart';
import 'package:hava/base/utils.dart';
import 'package:hava/models/know_model.dart';
import 'package:hava/screens/course/knowledge/theory/theory_view.dart';

class ItemLessFinalView extends StatelessWidget {
  final KnowModel model;
  final Function(int id) onExam;

  const ItemLessFinalView({Key? key, required this.model, required this.onExam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () => onTheoryView(context),
        leading: _img(),
        title: Text(model.title),
        trailing: const Icon(Icons.read_more_outlined),
      ),
    );
  }

  Widget _img() {
    return Image.asset('assets/icons/ic_lesson.png', width: 40, height: 40);
  }

  void onTheoryView(context) {
    if (model.examId == 0) {
      Utils.navigatePage(context, TheoryView(model: model));
    } else {
      onExam(model.examId);
    }
  }
}
