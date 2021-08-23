import 'package:flutter/material.dart';
import 'package:hava/themes/styles.dart';

class RowStep extends StatelessWidget {
  final String icon;
  final String title;

  // ignore: use_key_in_widget_constructors
  const RowStep({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(icon),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Flexible(child: Text(title, style: Styles.txtBold()))
        ],
      ),
    );
  }
}
