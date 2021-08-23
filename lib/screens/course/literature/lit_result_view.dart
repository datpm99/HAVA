import 'package:flutter_html/flutter_html.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_view.dart';
import 'lit_result_presenter.dart';

class LitResultView extends StatefulWidget {
  final QuestionModel model;
  final int index;

  const LitResultView({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  _LitResultViewState createState() => _LitResultViewState();
}

class _LitResultViewState extends State<LitResultView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late LitResultPresenter _presenter;

  @override
  void initState() {
    _presenter = LitResultPresenter(context, this, widget.model, widget.index);
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleQues(),
            Expanded(child: Html(data: widget.model.question)),
          ],
        ),
        const SizedBox(height: 10),
        (widget.model.answerA.isNotEmpty) ? _buildGuide(width) : Container(),
      ],
    );
  }

  Widget _titleQues() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Text(
            _presenter.titleQues,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 10),
          (widget.model.answerA.isNotEmpty) ? VAll.imgLight() : Container(),
        ],
      ),
    );
  }

  Widget _buildTxt2(String name, Color color, int type) {
    return GestureDetector(
      onTap: () => _presenter.onResult(type),
      child: Container(
        width: 100,
        height: 28,
        alignment: Alignment.center,
        decoration: VAll.deco2Rd5(color),
        child: Text(name, style: Styles.cusText(color: Styles.colorB2)),
      ),
    );
  }

  Widget _buildGuide(width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTxt2('Tư Duy', _presenter.colorGui, 1),
            const SizedBox(width: 1),
            _buildTxt2('Lời Giải', _presenter.colorSol, 2),
          ],
        ),
        Container(
          width: width,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          decoration: VAll.deco3Rd5(),
          child: Html(data: _presenter.nameGuide),
        ),
        const SizedBox(height: 10),
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
