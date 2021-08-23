import 'package:flutter/material.dart';
import 'package:hava/themes/styles.dart';
import 'package:hava/models/guide_model.dart';
import 'package:flutter_html/flutter_html.dart';

class ItemGuideView extends StatelessWidget {
  final GuideModel model;

  const ItemGuideView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = model.title;
    String content = model.contents;
    return Card(
      elevation: 1.5,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding:
              const EdgeInsets.only(left: 20, bottom: 20, right: 20),
          title: Text(title, style: Styles.cusText(color: Styles.colorB2)),
          leading: Image.asset('assets/icons/ic_qs.png', width: 30, height: 30),
          children: [
            Html(data: content),
          ],
        ),
      ),
    );
  }
}
