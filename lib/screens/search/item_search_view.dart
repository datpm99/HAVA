import 'package:hava/base/utils.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/models/search_model.dart';
import 'package:hava/screens/course/knowledge/theory/theory2_view.dart';

class ItemSearchView extends StatelessWidget {
  final SearchModel model;

  const ItemSearchView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTheory(context, model.id),
      child: Stack(
        children: [
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            decoration: VAll.decoRd5NonBr(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: Styles.cusText(color: Styles.colorB2),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${model.path} ',
                    style: Styles.txtBlack(color: Styles.colorG4, size: 13),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 90,
            width: 5,
            decoration: const BoxDecoration(
              color: Styles.colorMain,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onTheory(context, int id) {
    Utils.navigatePage(context, Theory2View(id: id));
  }
}
