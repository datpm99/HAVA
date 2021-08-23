import 'package:flutter/material.dart';
import 'package:hava/themes/styles.dart';

class AlertResultDialog extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback ok;
  final String title, content;

  const AlertResultDialog(
      {Key? key,
      required this.cancel,
      required this.ok,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
        content,
        style: Styles.copyStyle(color: Styles.colorB2, height: 1.2),
      ),
      actions: [
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: Styles.colorMain,
          onPressed: ok,
          child: Text('Đồng ý', style: Styles.copyStyle(color: Colors.white)),
        ),
        FlatButton(
          onPressed: cancel,
          color: Styles.colorG6,
          child: Text('Hủy', style: Styles.copyStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
