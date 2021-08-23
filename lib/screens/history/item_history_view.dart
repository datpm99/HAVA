import 'package:hava/models/history_model.dart';
import 'package:hava/src/lib_view.dart';

class ItemHistoryView extends StatelessWidget {
  final HistoryModel model;
  final String date;
  final String time;
  final Function onExamHis;

  const ItemHistoryView(
      {Key? key,
      required this.model,
      required this.date,
      required this.time,
      required this.onExamHis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onExamHis(
          model.idExam, model.catId, model.historyId, model.lstAnswer, model.type),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: VAll.decoRd5(Colors.white, 0.5, Styles.colorG10),
        child: Row(
          children: [
            Image.asset('assets/icons/ic_practice.png', width: 24, height: 24),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 220,
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    model.title,
                    style: Styles.cusText(color: Styles.colorB2),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '(${model.trueAnswer}/${model.totalQues})',
                  style: Styles.txtBlack(color: Styles.colorG1, size: 12),
                ),
              ],
            ),
            const Spacer(),
            Text('$time $date', style: Styles.txtBlack(color: Styles.colorG1)),
          ],
        ),
      ),
    );
  }
}
