import 'dart:convert';
import 'package:hava/even_bus/event.dart';
import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/screens/average/bottom_sheet/add_mark_sheet_view.dart';
import '../average_api_client.dart';

class ItemTabPresenter extends Presenter {
  ItemTabPresenter(
      BuildContext context, Contract view, this.model, this.term, this.idTran)
      : super(context, view);

  final MarkModel model;
  final int term, idTran;
  late AverageApiClient _apiClient;

  //Data.
  double markAll = 0;
  String markAllShow = '';
  bool isShow = false;
  List<ItemMarkModel> listMark = [];

  //Mark.
  List<double> listRaw = [];
  List<double> list1 = [];
  List<double> list2 = [];
  List<double> list3 = [];
  List<double> list4 = [];
  double mark1 = 0;
  double mark2 = 0;
  double mark3 = 0;
  double mark4 = 0;
  int other = 0;
  int idMark = 0;

  @override
  void init() {
    super.init();
    _apiClient = AverageApiClient(context);
    listMark = model.listMark;
    calMark1();
    calMark2();
    calMark3();
    calMark4();
    calMarkAll();
  }

  void calMark1() {
    ItemMarkModel modelM = listMark[0];
    if (modelM.mark.isNotEmpty) {
      String markRaw = modelM.mark.replaceAll(RegExp(r"\\"), "");
      List listRaw = json.decode(markRaw);
      list1 = listRaw.map((e) => double.parse(e)).toList();
      calReMark1();
    }
  }

  void calMark2() {
    ItemMarkModel modelM = listMark[1];
    if (modelM.mark.isNotEmpty) {
      String markRaw = modelM.mark.replaceAll(RegExp(r"\\"), "");
      List listRaw = json.decode(markRaw);
      list2 = listRaw.map((e) => double.parse(e)).toList();
      calReMark2();
    }
  }

  void calMark3() {
    ItemMarkModel modelM = listMark[2];
    if (modelM.mark.isNotEmpty) {
      String markRaw = modelM.mark.replaceAll(RegExp(r"\\"), "");
      List listRaw = json.decode(markRaw);
      list3 = listRaw.map((e) => double.parse(e)).toList();
      calReMark3();
    }
  }

  void calMark4() {
    ItemMarkModel modelM = listMark[3];
    if (modelM.mark.isNotEmpty) {
      String markRaw = modelM.mark.replaceAll(RegExp(r"\\"), "");
      List listRaw = json.decode(markRaw);
      list4 = listRaw.map((e) => double.parse(e)).toList();
      calReMark4();
    }
  }

  void calMarkAll() {
    markAll = 0;
    markAll = mark1 + mark2 + (mark3 * 2) + (mark4 * 3);
    markAll = markAll / 7;
    print('markall: $markAll');
    markAllShow = markAll.toStringAsPrecision(2);
  }

  void onChangeShow() {
    isShow = !isShow;
    view.updateState();
  }

  void showBottomSheet(List<double> list, int type) {
    listRaw.clear();
    listRaw.addAll(list);
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: (context) => AddMarkSheetView(
        list: listRaw,
        type: type,
        onDelMark: onDelMark,
        onAddMark: onAddMark,
        onUpMark: onUpMark,
      ),
    );
  }

  void onDelMark(int index) {
    listRaw.removeAt(index);
  }

  void onAddMark(double value) {
    listRaw.add(value);
  }

  void checkChange(List<double> list) {
    if (list.length != listRaw.length) {
      other = 1;
    } else {
      for (int i = 0; i < list.length; i++) {
        if (list[i] != listRaw[i]) {
          other = 1;
          break;
        }
      }
    }
  }

  void calReMark1() {
    mark1 = 0;
    for (int i = 0; i < list1.length; i++) {
      mark1 += list1[i];
    }
    mark1 = mark1 / list1.length;
  }

  void calReMark2() {
    mark2 = 0;
    for (int i = 0; i < list2.length; i++) {
      mark2 += list2[i];
    }
    mark2 = mark2 / list2.length;
  }

  void calReMark3() {
    mark3 = 0;
    for (int i = 0; i < list3.length; i++) {
      mark3 += list3[i];
    }
    mark3 = mark3 / list3.length;
  }

  void calReMark4() {
    mark4 = 0;
    for (int i = 0; i < list4.length; i++) {
      mark4 += list4[i];
    }
    mark4 = mark4 / list4.length;
  }

  void clearList(int type) {
    if (type == 1) list1.clear();
    if (type == 2) list2.clear();
    if (type == 3) list3.clear();
    if (type == 4) list4.clear();
  }

  void addNewList(int type) {
    if (type == 1) list1.addAll(listRaw);
    if (type == 2) list2.addAll(listRaw);
    if (type == 3) list3.addAll(listRaw);
    if (type == 4) list4.addAll(listRaw);
  }

  void calMarkNew(int type) {
    if (type == 1) calReMark1();
    if (type == 2) calReMark2();
    if (type == 3) calReMark3();
    if (type == 4) calReMark4();
  }

  void getIdMark(int type) {
    idMark = 0;
    if (type == 1) idMark = listMark[0].id;
    if (type == 2) idMark = listMark[1].id;
    if (type == 3) idMark = listMark[2].id;
    if (type == 4) idMark = listMark[3].id;
  }

  void onUpMark(int type) async {
    other = 0;
    if (type == 1) checkChange(list1);
    if (type == 2) checkChange(list2);
    if (type == 3) checkChange(list3);
    if (type == 4) checkChange(list4);
    if (other == 1) {
      if (listRaw.isNotEmpty) {
        showLoading();
        String mark = '';
        clearList(type);
        addNewList(type);
        calMarkNew(type);
        calMarkAll();
        getIdMark(type);
        for (int i = 0; i < listRaw.length; i++) {
          mark += "\"${listRaw[i]}\",";
        }
        mark = mark.substring(0, mark.length - 1);
        mark = '[' + mark + ']';
        print('mark: $mark');
        MarkUpModel modelUp = MarkUpModel(
            mark: mark, subId: model.id, term: term, typeMark: type);
        await _apiClient.updateMark(jsonEncode(modelUp), idMark);
        eventBus.fire(UpdateMarkEvent());
        userRes.isUpPoint = true;
        await hideLoading();
        onBack();
        view.updateState();
      }else{
        Utils.showToast('Em phải thêm ít nhất một điểm!');
      }
    }
  }
}
