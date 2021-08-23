import 'package:flutter_html/flutter_html.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_view.dart';
import 'item_eng_presenter.dart';

class ItemEngView extends StatefulWidget {
  final QuestionModel model;
  final int index;
  final bool showLight;

  const ItemEngView(
      {Key? key,
      required this.model,
      required this.index,
      required this.showLight})
      : super(key: key);

  @override
  _ItemEngViewState createState() => _ItemEngViewState();
}

class _ItemEngViewState extends State<ItemEngView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late ItemEngPresenter _presenter;

  @override
  void initState() {
    _presenter = ItemEngPresenter(context, this, widget.model, widget.index);
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
        (_presenter.answerTrue == 0) ? Container() : _light(),
        const SizedBox(height: 5),
        _guide(width),
        (_presenter.answerTrue == 0)
            ? Container()
            : Column(
                children: [
                  _rowQues(1, 'A:', _presenter.answerA),
                  _rowQues(2, 'B:', _presenter.answerB),
                  _rowQues(3, 'C:', _presenter.answerC),
                  _rowQues(4, 'D:', _presenter.answerD),
                ],
              ),
      ],
    );
  }

  Widget _light() {
    return Visibility(
      visible: widget.showLight,
      child: GestureDetector(
        onTap: _presenter.onGuide,
        child: VAll.imgLight(),
      ),
    );
  }

  Widget _radioQues(int value) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Radio(
        value: value,
        groupValue: _presenter.radioGroup,
        onChanged: _presenter.onChange,
      ),
    );
  }

  Widget _rowQues(int value, String title, String txt) {
    return Row(
      children: [
        _radioQues(value),
        const SizedBox(width: 5),
        Text(title, style: Styles.cusText(color: Styles.colorB2)),
        Expanded(child: Html(data: txt)),
      ],
    );
  }

  Widget _buildTxt() {
    return Container(
      width: 100,
      height: 28,
      alignment: Alignment.center,
      decoration: VAll.deco2Rd5(Styles.colorG10),
      child: Text('Tư Duy', style: Styles.cusText(color: Styles.colorB2)),
    );
  }

  Widget _guide(width) {
    return Visibility(
      visible: _presenter.isGuide,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTxt(),
          Container(
            width: width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            decoration: VAll.deco3Rd5(),
            child: Html(data: _presenter.hint),
          ),
          const SizedBox(height: 10),
        ],
      ),
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
                  _presenter.indexQues,
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
