import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hava/themes/styles.dart';

class NoDataView extends StatelessWidget {
  final String title;
  final bool isListView;
  final double size;

  const NoDataView(
      {Key? key,
      required this.title,
      required this.isListView,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: size,
        width: size,
        child: Text(
          title,
          style: const TextStyle(color: Styles.colorG5, fontSize: 18),
        ),
      ),
    );
  }
}
