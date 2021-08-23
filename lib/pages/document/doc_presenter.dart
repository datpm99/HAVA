import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/doc_model.dart';
import 'doc_api_client.dart';
import 'document_item_view.dart';

class DocPresenter extends Presenter {
  DocPresenter(BuildContext context, Contract view) : super(context, view);
  late DocApiClient _docApiClient;
  List<DocModel> listDoc = [];

  @override
  void init() {
    super.init();
    _docApiClient = DocApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    listDoc = await _docApiClient.getDoc();
    for (int i = 1; i < 10; i++) {
      for (int j = 0; j < listDoc.length; j++) {
        if (listDoc[j].docCateId == i) {
          list.add(listDoc[j]);
          break;
        }
      }
    }
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      DocModel model = list[index];
      double type = 0;
      if (model.docCateId == 6 || model.docCateId == 9) type = 40;
      return DocumentItemView(
        model: model,
        icon: Utils.imgDoc[model.docCateId - 1],
        nameSub: Utils.listSubDoc[model.docCateId - 1],
        wImg: userRes.wImg,
        icImg1: userRes.icImg1,
        type: type,
        cateId: model.docCateId,
      );
    }
    return super.itemBuild(context, index);
  }
}
