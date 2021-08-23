import 'package:hava/models/exam_model.dart';
import 'package:hava/src/lib_view.dart';
import 'exam_dialog_presenter.dart';

class ExamDialog extends StatefulWidget {
  final List list;
  final int easy, normal, hard, idSubject, idExam;
  final VoidCallback onBack;
  final String title;

  const ExamDialog(
      {Key? key,
      required this.list,
      required this.easy,
      required this.normal,
      required this.hard,
      required this.onBack,
      required this.title,
      required this.idSubject,
      required this.idExam})
      : super(key: key);

  @override
  _ExamDialogState createState() => _ExamDialogState();
}

class _ExamDialogState extends State<ExamDialog> implements Contract {
  late ExamDialogPresenter _presenter;

  @override
  void initState() {
    _presenter =
        ExamDialogPresenter(context, this, widget.idSubject, widget.idExam);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height / 1.4,
        child: Column(
          children: [_itemFirst(), Expanded(child: _listExam())],
        ),
      ),
    );
  }

  Widget _itemFirst() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: Styles.txtBold(color: Styles.colorB2),
          ),
        ),
        GestureDetector(onTap: _presenter.onBack, child: VAll.btnDelete())
      ],
    );
  }

  Widget _listExam() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        ExamModel model = widget.list[index];
        if (index == widget.easy) return _itemName('Đề Dễ', 15.0);
        if (index == widget.normal) return _itemName('Trung Bình', 30.0);
        if (index == widget.hard) return _itemName('Đề Khó', 30.0);
        return _itemList(context, model.title, model.id, model.isFree);
      },
    );
  }

  Widget _itemList(context, String name, int id, int free) {
    String test = (free == 1) ? ' (Thử)' : '';
    return GestureDetector(
      onTap: () => _presenter.onCheckActive(free, id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: VAll.decoR5C(Styles.colorG10),
        child: Row(
          children: [
            Image.asset('assets/icons/ic_practice.png', width: 24, height: 24),
            const SizedBox(width: 10),
            Flexible(child: _txtRich(name, test)),
          ],
        ),
      ),
    );
  }

  Widget _itemName(name, size) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 34,
          margin: EdgeInsets.only(bottom: 10, top: size),
          alignment: Alignment.center,
          decoration: VAll.decoCR(),
          child: Text(name, style: Styles.cusText(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _txtRich(String txt1, String txt2) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: txt1,
        style: const TextStyle(color: Styles.colorB2),
        children: <TextSpan>[
          TextSpan(
            text: txt2,
            style: const TextStyle(
              color: Styles.colorGreen1,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
