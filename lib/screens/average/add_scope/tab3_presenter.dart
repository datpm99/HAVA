import 'dart:convert';
import 'package:hava/even_bus/event.dart';
import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_presenter.dart';
import '../average_api_client.dart';

class Tab3Presenter extends Presenter {
  Tab3Presenter(BuildContext context, Contract view, this.idTran)
      : super(context, view);
  final int idTran;
  late AverageApiClient _apiClient;

  double markAll = 0;
  String markShow = '';
  List<double> listMTerm1 = [];
  List<double> listMTerm2 = [];
  List<double> listMAll = [];

  @override
  void init() {
    super.init();
    _apiClient = AverageApiClient(context);
    eventBus.on<UpdateMarkEvent>().listen((event) {
      calTerm1();
      calTerm2();
      calTermAll();
      calMarkAll();
      view.updateState();
    });
  }

  @override
  void loadData() async {
    super.loadData();
    if (userRes.listTerm1.isEmpty) {
      userRes.listTerm1 = await _apiClient.getMarkByTerm(idTran, 1);
    }
    if (userRes.listTerm2.isEmpty) {
      userRes.listTerm2 = await _apiClient.getMarkByTerm(idTran, 2);
    }
    list.addAll(userRes.listTerm1);
    calTerm1();
    calTerm2();
    calTermAll();
    calMarkAll();
    view.updateState();
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

  void calTerm1() {
    for (int i = 0; i < userRes.listTerm1.length; i++) {
      MarkModel model = userRes.listTerm1[i];
      double markRaw = calMarkSub(model.listMark);
      listMTerm1.add(markRaw);
    }
  }

  void calTerm2() {
    for (int i = 0; i < userRes.listTerm2.length; i++) {
      MarkModel model = userRes.listTerm2[i];
      double markRaw = calMarkSub(model.listMark);
      listMTerm2.add(markRaw);
    }
  }

  void calTermAll() {
    for (int i = 0; i < userRes.listTerm1.length; i++) {
      double markRaw = (listMTerm1[i] + (listMTerm2[i] * 2)) / 3;
      listMAll.add(markRaw);
    }
  }

  void calMarkAll() {
    for (int i = 0; i < listMAll.length; i++) {
      markAll += listMAll[i];
    }
    markAll = markAll / listMAll.length;
    markShow = markAll.toStringAsPrecision(2);
  }
}
