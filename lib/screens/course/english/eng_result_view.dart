import 'package:flutter_html/flutter_html.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_view.dart';
import 'eng_result_presenter.dart';

class EngResultView extends StatefulWidget {
  final QuestionModel model;
  final int indexList;
  final int index;

  const EngResultView(
      {Key? key,
      required this.model,
      required this.indexList,
      required this.index})
      : super(key: key);

  @override
  _EngResultViewState createState() => _EngResultViewState();
}

class _EngResultViewState extends State<EngResultView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late EngResultPresenter _presenter;

  @override
  void initState() {
    _presenter = EngResultPresenter(context, this, widget.model, widget.index);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _presenter.valueLable,
          style: Styles.cusText(color: Styles.colorB2),
        ),
        const SizedBox(height: 5),
        _txtNumQues(),
        const SizedBox(height: 5),
        (_presenter.answerTrue == 0) ? Container() : VAll.imgLight(),
        const SizedBox(height: 5),
        (_presenter.answerTrue == 0) ? Container() : _guide(width),
        (_presenter.answerTrue == 0)
            ? Container()
            : Column(
                children: [
                  _rowQues('A:', _presenter.answerA, _presenter.colorA,
                      _presenter.colorCircleA),
                  _rowQues('B:', _presenter.answerB, _presenter.colorB,
                      _presenter.colorCircleB),
                  _rowQues('C:', _presenter.answerC, _presenter.colorC,
                      _presenter.colorCircleC),
                  _rowQues('D:', _presenter.answerD, _presenter.colorD,
                      _presenter.colorCircleD),
                ],
              ),
      ],
    );
  }

  Widget _rowQues(String title, String txt, Color color, Color circle) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5, color: circle),
          ),
          child: Text(title, style: Styles.cusText(color: color)),
        ),
        Expanded(
          child: Html(
            data: txt,
            style: {
              "p": Style(color: color),
              "span": Style(color: color),
            }
          ),
        ),
      ],
    );
  }

  Widget _buildTxt(int type, String name, Color color) {
    return GestureDetector(
      onTap: () => _presenter.onChangeGuide(type),
      child: Container(
        width: 100,
        height: 28,
        alignment: Alignment.center,
        decoration: VAll.deco2Rd5(color),
        child: Text(name, style: Styles.cusText(color: Styles.colorB2)),
      ),
    );
  }

  Widget _guide(width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            _buildTxt(1, 'Tư Duy', _presenter.colorGuide),
            _buildTxt(2, 'Lời Giải', _presenter.colorAnswer),
            _buildTxt(3, 'Nhận Xét', _presenter.colorComment),
          ],
        ),
        Container(
          width: width,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          decoration: VAll.deco3Rd5(),
          child: Html(data: _presenter.hint),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _txtNumQues() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (_presenter.answerTrue == 0)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Câu ${widget.indexList + 1}:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
        Expanded(child: Html(data: _presenter.question)),
      ],
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
