import 'package:hava/src/lib_presenter.dart';
import 'package:hava/base/const.dart';
import 'package:hava/base/view_all.dart';
import 'package:hava/models/doc_model.dart';
import 'package:hava/screens/ebook/ebook_api_client.dart';
import 'package:hava/screens/item_doc/item/item_doc_view.dart';

class EbookPresenter extends Presenter {
  EbookPresenter(BuildContext context, Contract view) : super(context, view);
  bool isShow = true;
  EbookApiClient? _ebookApiClient;

  @override
  void init() {
    _ebookApiClient = EbookApiClient(context);
    super.init();
  }

  @override
  void loadData() async {
    list = await _ebookApiClient!.getDocById(10);
    super.loadData();
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      DocModel model = list[index];
      String nameSub = '';
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

  void onItemDoc(DocModel model, String nameSub) {
    Utils.navigatePage(context, ItemDocView(model: model, nameSub: nameSub));
  }

  void onHideView() {
    isShow = false;
    view.updateState();
  }
}
