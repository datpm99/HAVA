import 'package:hava/base/utils.dart';
import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_view.dart';
import 'add_scope/add_scope_view.dart';

class ItemAverageView extends StatelessWidget {
  final TranModel model;
  final Function onDelete, onDetail;

  const ItemAverageView({Key? key, required this.model, required this.onDelete,required this.onDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDetail(model),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
            decoration: VAll.decoRd5NonBr(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _txtTitle(model.name),
                    _txtTitle(model.classBelong),
                    _txtContent1(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(height: 1, color: Styles.colorG10),
                ),
                _txtContent2(),
                _txtContent3(),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _txtAverage(name: 'Học kì 1:', scope: model.avgTerm1),
                    _txtAverage(name: 'Học kì 2:', scope: model.avgTerm2),
                    _txtAverage(name: 'Cả năm:', scope: model.avgAllTerm),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
            alignment: Alignment.topRight,
            child: _btnDelete(),
          ),
        ],
      ),
    );
  }

  Widget _txtTitle(String name) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Styles.colorG14,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(name, style: Styles.cusText(color: Styles.colorB4)),
    );
  }

  Widget _txtContent1() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Styles.colorOr3,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        model.title,
        style:
            const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _txtContent2() {
    return RichText(
      text: TextSpan(
        text: 'Tổng số môn được tính điểm là  ',
        style: const TextStyle(
            fontSize: 12, color: Styles.colorB2, fontStyle: FontStyle.italic),
        children: <TextSpan>[
          TextSpan(
            text: '${model.totalSub}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _txtContent3() {
    return const Padding(
      padding: EdgeInsets.only(top: 4, bottom: 10),
      child: Text(
        'Điểm trung bình hiện tại',
        style: TextStyle(
          color: Styles.colorB2,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _txtAverage({String name = '', double scope = 0}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: VAll.decoNonShadow(Colors.white, 0.5, Styles.colorG6),
      child: RichText(
        text: TextSpan(
          text: name,
          style: const TextStyle(
              color: Styles.colorB2, fontSize: 12, fontStyle: FontStyle.italic),
          children: <TextSpan>[
            TextSpan(
              text: '  $scope',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _btnDelete() {
    return GestureDetector(
      onTap: () => onDelete(model.id),
      child: const Icon(Icons.delete, color: Styles.colorG6),
    );
  }
}
