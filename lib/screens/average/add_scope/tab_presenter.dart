import 'dart:convert';

import 'package:hava/even_bus/event.dart';
import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_presenter.dart';
import '../average_api_client.dart';
import 'item_tab_view.dart';

class TabPresenter extends Presenter {
  TabPresenter(BuildContext context, Contract view, this.idTran, this.term)
      : super(context, view);
  final int idTran, term;
  late AverageApiClient _apiClient;
  double markAll = 0;
  String markShow = '';

  @override
  void init() {
    super.init();
    _apiClient = AverageApiClient(context);
    eventBus.on<UpdateMarkEvent>().listen((event) async {
        list = await _apiClient.getMarkByTerm(idTran, term);
        calMarkAll();
        view.updateState();
    });
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _apiClient.getMarkByTerm(idTran, term);
    calMarkAll();
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      return ItemTabView(model: list[index], term: term, idTran: idTran);
    }
    return super.itemBuild(context, index);
  }

  double calMarkSub(List<ItemMarkModel> listMark) {
    double markSub = 0;
    List<double> listM = [];
    for (ItemMarkModel model in listMark) {
      if (model.mark.isNotEmpty) {
        String markRaw = model.mark.replaceAll(RegExp(r"\\"), "");
        List listRaw = json.decode(markRaw);
        List listD = listRaw.map((e) => double.parse(e)).toList();
        double mark = 0;
        for (int i = 0; i < listD.length; i++) {
          mark += listD[i];
        }
        mark = mark / listD.length;
        listM.add(mark);
      } else {
        listM.add(0);
      }
    }
    markSub = (listM[0] + listM[1] + (listM[2] * 2) + (listM[3] * 3)) / 7;
    return markSub;
  }

  void calMarkAll() {
    markAll = 0;
    for (int i = 0; i < list.length; i++) {
      MarkModel modelM = list[i];
      List<ItemMarkModel> listMark = modelM.listMark;
      markAll += calMarkSub(listMark);
    }
    markAll = markAll / list.length;
    markShow = markAll.toStringAsPrecision(2);
  }
}
