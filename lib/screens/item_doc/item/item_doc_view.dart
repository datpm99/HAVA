import 'package:hava/src/lib_view.dart';
import 'package:hava/base/const.dart';
import 'package:hava/models/doc_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'item_doc_presenter.dart';

class ItemDocView extends StatefulWidget {
  final DocModel model;
  final String nameSub;

  const ItemDocView({Key? key, required this.model, required this.nameSub})
      : super(key: key);

  @override
  _ItemDocViewState createState() => _ItemDocViewState();
}

class _ItemDocViewState extends State<ItemDocView> implements Contract {
  late ItemDocPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ItemDocPresenter(context, this, widget.model);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 80 - 88;
    return Scaffold(
      appBar: AppBar(title: Text('Tài liệu ${widget.nameSub}')),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 75,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _presenter.nameDoc,
                      style: Styles.txtBold(color: Styles.colorB2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  _buildBtn(),
                ],
              ),
            ),
            const Divider(height: 1, color: Styles.colorG10),
            SizedBox(
              height: height,
              child: SfPdfViewer.network(
                '${Const.urlImg}${_presenter.linkDoc}',
                controller: _presenter.pdfViewerController,
                searchTextHighlightColor: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn() {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(8),
      color: Styles.colorMain,
      onPressed: _presenter.onDownload,
      icon: const Icon(Icons.download_sharp, color: Colors.white, size: 18),
      label: Text(
        'Tải về máy',
        style: Styles.copyStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
