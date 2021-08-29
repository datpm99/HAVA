import 'dart:io';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/base/const.dart';
import 'package:hava/models/doc_model.dart';
import 'package:hava/screens/item_doc/dialog/download_dialog_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;

class ItemDocPresenter extends Presenter {
  ItemDocPresenter(BuildContext context, Contract view, this.model)
      : super(context, view);

  final DocModel model;
  bool isSearch = false;

  String get nameDoc => model.title;

  String get linkDoc => model.href;

  PdfViewerController? pdfViewerController;
  PdfTextSearchResult? searchResult;
  TextEditingController? txtPage;

  @override
  void init() {
    super.init();
    txtPage = TextEditingController();
    pdfViewerController = PdfViewerController();
  }

  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getTemporaryDirectory();
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }

  Future startDownload() async {
    String fileName = linkDoc.substring(linkDoc.lastIndexOf("/") + 1);
    String urlPath = '${Const.urlImg}$linkDoc';

    final dir = await getDownloadDirectory();
    String savePath = path.join(dir!.path, fileName);
    File(savePath).exists().then((a) async {
      if (a) {
        Utils.showToast('Em đã tải tài liệu này rồi!');
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DownloadDialogView(
            urlPath: urlPath,
            savePath: savePath,
          ),
        );
      }
    });
  }

  void onDownload() async {
    Utils.askPermissionStore(context, startDownload);
  }
}
