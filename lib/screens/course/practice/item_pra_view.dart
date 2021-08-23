import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_view.dart';
import 'item_pra_presenter.dart';

class ItemPraView extends StatefulWidget {
  final QuestionModel model;
  final int index, idSub;
  final bool showLight;

  const ItemPraView(
      {Key? key,
      required this.model,
      required this.index,
      required this.showLight,
      required this.idSub})
      : super(key: key);

  @override
  _ItemPraViewState createState() => _ItemPraViewState();
}

class _ItemPraViewState extends State<ItemPraView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late ItemPraPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ItemPraPresenter(context, this, widget.model, widget.index);
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
          _light(),
          const SizedBox(height: 5),
          _blocGuide(width),
          (widget.idSub == 4 || _presenter.smallA)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rowQues(1, 'A:', _presenter.anA),
                    _rowQues(2, 'B:', _presenter.anB),
                    _rowQues(3, 'C:', _presenter.anC),
                    _rowQues(4, 'D:', _presenter.anD),
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
                        child: _rowQues(1, 'A:', _presenter.anA),
                      ),
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues(2, 'B:', _presenter.anB),
                      ),
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues(3, 'C:', _presenter.anC),
                      ),
                      SizedBox(
                        width: _presenter.reA,
                        child: _rowQues(4, 'D:', _presenter.anD),
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
      "tex": (context, element) => Math.tex(
            context.tree.element!.text,
            onErrorFallback: (FlutterMathException e) {
              return Text(e.message);
            },
            mathStyle: MathStyle.text,
            textStyle: const TextStyle(fontSize: 14),
          )
    }, style: {
      "p": Style(color: Styles.colorB2, fontSize: FontSize.medium),
      "span": Style(color: Styles.colorB2, fontSize: FontSize.medium),
    });
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

  Widget _blocRadioQues({int value = 0}) {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is ClickRadioState,
        builder: (context, state) {
          return SizedBox(
            width: 24,
            height: 24,
            child: Radio(
              value: value,
              groupValue: _presenter.radioGroup,
              onChanged: _presenter.onChange,
            ),
          );
        });
  }

  Widget _rowQues(int value, String title, String txt) {
    return Row(
      children: [
        _blocRadioQues(value: value),
        const SizedBox(width: 5),
        Text(title, style: Styles.cusText(color: Styles.colorB2)),
        Expanded(child: _htmlView(txt)),
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

  Widget _blocGuide(width) {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is ClickLightState,
        builder: (context, state) {
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
                  child: (_presenter.smallH)
                      ? _htmlView(_presenter.hin)
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: _presenter.reH,
                            child: _htmlView(_presenter.hin),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        });
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
