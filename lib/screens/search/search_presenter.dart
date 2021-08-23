import 'package:hava/models/search_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'item_search_view.dart';
import 'search_api_client.dart';

class SearchPresenter extends Presenter {
  SearchPresenter(BuildContext context, Contract view) : super(context, view);

  TextEditingController txtController = TextEditingController();
  late SearchApiClient _searchApiClient;
  String txtResult = '';
  String txtNotify = 'Nhập thông tin để tìm kiếm tài liệu.';
  bool isStart = true;

  @override
  void init() {
    super.init();
    _searchApiClient = SearchApiClient(context);
  }

  void onSearch(String? txt) async {
    String txtSearch = '$txt';
    isStart = false;
    if (txtSearch.isNotEmpty) {
      list = await _searchApiClient.getSearch(txtSearch);
      txtNotify = 'Kết quả tìm kiếm: "$txt"';
      view.updateState();
    } else {
      Utils.showToast('Em chưa nhập thông tin tìm kiếm!');
    }
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      SearchModel model = list[index];
      return ItemSearchView(model: model);
    }
    return super.itemBuild(context, index);
  }

  Widget myItemBuilder(BuildContext context, int index) {
    if (isStart) {
      return const SizedBox.shrink();
    } else {
      if (list.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        return itemBuild(context, index);
      }
    }
  }
}
