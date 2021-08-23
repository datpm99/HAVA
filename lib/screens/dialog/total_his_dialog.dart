import 'package:hava/base/utils.dart';
import 'package:hava/models/total_his_model.dart';
import 'package:hava/screens/course/knowledge/theory/theory2_view.dart';
import 'package:hava/src/lib_view.dart';

class TotalHisDialog extends StatelessWidget {
  final Function() onBack;
  final List<TotalHisModel> listTotal;
  final double txtSize;

  const TotalHisDialog({
    Key? key,
    required this.onBack,
    required this.listTotal,
    required this.txtSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: VAll.decoSheet(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bảng đánh giá',
                  style: Styles.cusText(color: Styles.colorB4),
                ),
                GestureDetector(onTap: onBack, child: VAll.btnDelete()),
              ],
            ),
          ),
          const Divider(height: 1),
          _tableTitle(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _buildTable(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableTitle() {
    return Table(
      border: TableBorder.all(width: 0.5, color: Styles.colorG3),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(25),
        1: FlexColumnWidth(100),
        2: FlexColumnWidth(35),
        3: FlexColumnWidth(80),
      },
      children: [
        TableRow(children: [
          _buildTitle('#'),
          _buildTitle('Tên chuyên đề'),
          _buildTitle('Thống\nkê'),
          _buildTitle('Câu hỏi thuộc chuyên đề'),
        ]),
      ],
    );
  }

  Widget _buildTable(context) {
    return Table(
      border: TableBorder.all(width: 0.5, color: Styles.colorG3),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(25),
        1: FlexColumnWidth(100),
        2: FlexColumnWidth(35),
        3: FlexColumnWidth(80),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _genRowTable(context),
    );
  }

  Widget _buildTitle(String name) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      color: Styles.colorOr4,
      child: Text(name,
          style: Styles.cusText(size: txtSize), textAlign: TextAlign.center),
    );
  }

  Widget _txtRow1(String name) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Text(
        name,
        style: Styles.copyStyle(color: Styles.colorB2, fontSize: txtSize),
      ),
    );
  }

  Widget _buildTxt(String name, int id, context) {
    return GestureDetector(
      onTap: () => onTheory2(context, id),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          name,
          style: Styles.copyStyle(
              color: (id == -1) ? Styles.colorB2 : Colors.blue, fontSize: 12),
        ),
      ),
    );
  }

  //Generate.
  List<TableRow> _genRowTable(context) {
    List<TableRow> con = List<TableRow>.generate(listTotal.length, (index) {
      return TableRow(children: [
        _txtRow1('${index + 1}'),
        _buildTxt(listTotal[index].title, listTotal[index].idTheory, context),
        _txtRow1(
            '${listTotal[index].selectedQuestionTrue}/${listTotal[index].totalQuestionOfCat}'),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Wrap(
            children: _genListAns(listTotal[index].listAns),
          ),
        )
      ]);
    });
    return con;
  }

  List<Widget> _genListAns(List<ListAnsModel>? list) {
    List<Text> con = List<Text>.generate(list!.length, (index) {
      String txt = (index == list.length - 1) ? '.' : ', ';
      return Text(
        '${list[index].questionNumber}$txt',
        style: TextStyle(
            fontSize: 12,
            color: (list[index].isRight == 0)
                ? Styles.colorRed3
                : Styles.colorGreen1),
      );
    });
    return con;
  }

  void onTheory2(context, int id) {
    if (id != -1) {
      Utils.navigatePage(context, Theory2View(id: id));
    }
  }
}
