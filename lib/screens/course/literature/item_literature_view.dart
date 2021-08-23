import 'package:hava/src/lib_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hava/models/question_model.dart';
import 'item_literature_presenter.dart';

class ItemLiteratureView extends StatefulWidget {
  final QuestionModel model;
  final int index;
  final bool showLight;

  const ItemLiteratureView(
      {Key? key,
      required this.model,
      required this.index,
      required this.showLight})
      : super(key: key);

  @override
  State<ItemLiteratureView> createState() => _ItemLiteratureViewState();
}

class _ItemLiteratureViewState extends State<ItemLiteratureView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late ItemLiteraturePresenter _presenter;

  @override
  void initState() {
    _presenter =
        ItemLiteraturePresenter(context, this, widget.model, widget.index);
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
          (widget.model.answerA.isNotEmpty) ? _light() : Container(),
        ],
      ),
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

  Widget _buildTxt() {
    return Container(
      width: 100,
      height: 28,
      alignment: Alignment.center,
      decoration: VAll.deco2Rd5(Styles.colorG10),
      child: Text('Tư Duy', style: Styles.cusText(color: Styles.colorB2)),
    );
  }

  Widget _buildGuide(width) {
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
            child: Html(data: widget.model.hints),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
