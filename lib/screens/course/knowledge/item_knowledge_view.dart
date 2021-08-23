import 'package:hava/models/know_model.dart';
import 'package:hava/src/lib_view.dart';
import 'item_knowledge_presenter.dart';

class ItemKnowledgeView extends StatefulWidget {
  final String sub;
  final KnowModel model;
  final int idSub;

  const ItemKnowledgeView({Key? key, required this.sub, required this.model,required this.idSub})
      : super(key: key);

  @override
  State<ItemKnowledgeView> createState() => _ItemKnowledgeViewState();
}

class _ItemKnowledgeViewState extends State<ItemKnowledgeView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late ItemKnowledgePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter =
        ItemKnowledgePresenter(context, this, widget.model, widget.sub, widget.idSub);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _presenter.onLesson,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: VAll.decoRd5(Colors.white, 0.5, Styles.colorG7),
        child: Row(
          children: [
            const SizedBox(width: 5),
            _buildHead(),
            _buildCol(width),
          ],
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 14),
      decoration: VAll.boxImg('assets/images/bg_kt.png'),
      child: Text(
        widget.sub,
        style: Styles.txtBlack(size: 10, color: Styles.colorB4),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCol(double width) {
    return Container(
      width: width - 140,
      height: 80,
      padding: const EdgeInsets.fromLTRB(8, 7, 5, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.model.title,
              style: Styles.cusText(color: Styles.colorB2, size: _presenter.userRes.fSize+2),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                '${_presenter.list.length} bài học',
                style: Styles.txtBlack(color: Styles.colorG9),
              ),
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.colorG9,
                ),
              ),
              const Icon(Icons.star, color: Styles.colorY3, size: 14),
              const Icon(Icons.star, color: Styles.colorY3, size: 14),
              const Icon(Icons.star, color: Styles.colorY3, size: 14),
              const Icon(Icons.star, color: Styles.colorY3, size: 14),
            ],
          ),
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
