import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_view.dart';
import 'pra_result_presenter.dart';

class PraResultView extends StatefulWidget {
  final QuestionModel model;
  final int index, idSub;

  const PraResultView(
      {Key? key, required this.model, required this.index, required this.idSub})
      : super(key: key);

  @override
  _PraResultViewState createState() => _PraResultViewState();
}

class _PraResultViewState extends State<PraResultView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late PraResultPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = PraResultPresenter(context, this, widget.model, widget.index);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_presenter.isSmall)
              ? _htmlView(_presenter.ques)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: _presenter.reWidth,
                    child: _htmlView(_presenter.ques),
                  ),
                ),
          VAll.imgLight(),
          const SizedBox(height: 5),
          _guide(width),
          (widget.idSub == 4 || _presenter.smallA)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rowQues('A:', _presenter.anA, _presenter.colorA,
                        _presenter.colorCircleA),
                    _rowQues('B:', _presenter.anB, _presenter.colorB,
                        _presenter.colorCircleB),
                    _rowQues('C:', _presenter.anC, _presenter.colorC,
                        _presenter.colorCircleC),
                    _rowQues('D:', _presenter.anD, _presenter.colorD,
                        _presenter.colorCircleD),
                  ],
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues('A:', _presenter.anA, _presenter.colorA,
                            _presenter.colorCircleA),
                      ),
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues('B:', _presenter.anB, _presenter.colorB,
                            _presenter.colorCircleB),
                      ),
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues('C:', _presenter.anC, _presenter.colorC,
                            _presenter.colorCircleC),
                      ),
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues('D:', _presenter.anD, _presenter.colorD,
                            _presenter.colorCircleD),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _htmlView(String txt) {
    return Html(data: txt, tagsList: Html.tags..add("tex"), customRender: {
      "tex": (context, element) => Math.tex(context.tree.element!.text,
              onErrorFallback: (FlutterMathException e) {
            return Text(e.message);
          })
    }, style: {
      "p": Style(color: Styles.colorB2, fontSize: FontSize.medium),
      "span": Style(color: Styles.colorB2, fontSize: FontSize.medium),
    });
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
          child:
              Html(data: txt, tagsList: Html.tags..add("tex"), customRender: {
            "tex": (context, element) => Math.tex(
                  context.tree.element!.text,
                  onErrorFallback: (FlutterMathException e) {
                    return Text(e.message);
                  },
                  mathStyle: MathStyle.text,
                  textStyle: TextStyle(color: color, fontSize: 14),
                )
          }, style: {
            "p": Style(color: color, fontSize: FontSize.medium),
            "span": Style(color: color, fontSize: FontSize.medium),
          }),
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
          child: (_presenter.smallH)
              ? _htmlView(_presenter.hint)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: _presenter.reH,
                    child: _htmlView(_presenter.hint),
                  ),
                ),
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
