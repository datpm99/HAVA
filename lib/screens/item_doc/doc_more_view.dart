import 'package:hava/base/utils.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/models/doc_model.dart';
import 'doc_more_presenter.dart';

class DocMoreView extends StatefulWidget {
  final DocModel model;
  final String nameSub;
  final int cateId;

  const DocMoreView(
      {Key? key,
      required this.model,
      required this.nameSub,
      required this.cateId})
      : super(key: key);

  @override
  _DocMoreViewState createState() => _DocMoreViewState();
}

class _DocMoreViewState extends State<DocMoreView> implements Contract {
  late DocMorePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DocMorePresenter(context, this, widget.nameSub, widget.cateId);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tài liệu ${widget.nameSub}')),
      body: Column(
        children: [
          _buildItemFirst(),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (1 / _presenter.childAspectRatio),
                crossAxisSpacing: _presenter.userRes.crossAxis,
                mainAxisSpacing: _presenter.userRes.mainAxis,
              ),
              itemCount: _presenter.list.length + 1,
              itemBuilder: _presenter.itemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemFirst() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Image.asset(
            Utils.imgDoc[widget.model.docCateId - 1],
            width: _presenter.userRes.icImg1,
            height: _presenter.userRes.icImg1,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Text(
            widget.nameSub,
            style: Styles.cusText(color: Styles.colorB2, size: 16),
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
