import 'package:hava/src/lib_presenter.dart';
import 'package:hava/base/const.dart';
import 'package:hava/base/view_all.dart';
import 'package:hava/models/doc_model.dart';
import 'doc_more_api_client.dart';
import 'item/item_doc_view.dart';

class DocMorePresenter extends Presenter {
  DocMorePresenter(
      BuildContext context, Contract view, this.nameSub, this.cateId)
      : super(context, view);
  final String nameSub;
  final int cateId;
  late DocMoreApiClient _docMoreApiClient;

  double childAspectRatio = 1.2;

  @override
  void init() {
    super.init();
    _docMoreApiClient = DocMoreApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    try {
      list = await _docMoreApiClient.getDocById(cateId);
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
    if (cateId == 6 || cateId == 9) childAspectRatio = 1;
    view.updateState();
  }

  void onItemDoc(DocModel model, String nameSub) {
    Utils.navigatePage(context, ItemDocView(model: model, nameSub: nameSub));
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      DocModel model = list[index];
      String nameSub = Utils.listSubDoc[model.docCateId - 1];
      String img = model.thumbnail;
      return VAll.itemSub(
        img: '${Const.urlImg}$img',
        type: 0,
        onTap: () => onItemDoc(model, nameSub),
        wImg: userRes.wImg,
      );
    }
    return super.itemBuild(context, index);
  }
}
