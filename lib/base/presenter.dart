import 'dart:io';
import 'dart:async';
import 'package:hava/models/question_model.dart';
import 'package:hava/screens/active_course/notify_dialog_active.dart';
import 'package:hava/screens/note/note_dialog_view.dart';
import 'package:html_unescape/html_unescape.dart';

import 'contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hava/view/no_data_view.dart';
import 'package:hava/auth/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Presenter {
  Presenter(this.context, this.view) {
    _init();
    init();
  }

  final BuildContext context;
  final Contract view;
  List list = [];
  bool isFirst = true;
  final ScrollController controller = ScrollController();
  var unescape = HtmlUnescape();

  UserRepository get userRes => RepositoryProvider.of<UserRepository>(context);

  void init() {}

  Future _init() async {
    controller.addListener(() {
      final maxScroll = controller.position.maxScrollExtent;
      if (controller.offset >= maxScroll && !controller.position.outOfRange) {
        loadMore();
      }
    });
  }

  Future onRefresh(){
    loadData();
    return Future.value(true);
  }


  void loadMore() {}

  void loadData() {
    isFirst = false;
  }

  void onBack({value}) {
    Navigator.of(context).pop(value);
  }

  bool _isShowDialog = false;

  void showLoading() {
    _isShowDialog = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(radius: 15),
            ),
          ),
        );
      },
    );
  }

  Future hideLoading() async {
    if (!_isShowDialog) return;
    if (Navigator.of(context).canPop()) {
      return Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pop();
        _isShowDialog = false;
      });
    }
  }

  void loadingData(String name) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: SizedBox(
            width: 100,
            height: 50,
            child: Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(radius: 15),
            ),
          ),
        );
      },
    );
  }

  Widget loadingView() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(radius: 15),
      ),
    );
  }

  Widget noDataView(
      {bool isListView = false, String title = '', double size = 300}) {
    return NoDataView(
      title: title,
      isListView: isListView,
      size: size,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (isFirst && list.isEmpty) {
      return loadingView();
    } else {
      if (list.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        return itemBuild(context, index);
      }
    }
  }

  Widget itemBuild(BuildContext context, int index) {
    return Container();
  }

  bool checkSubActive(int idSub) {
    if (idSub == 1) {
      if (userRes.user!.isMath) return true;
    } else if (idSub == 2) {
      if (userRes.user!.isPhysics) return true;
    } else if (idSub == 3) {
      if (userRes.user!.isChemistry) return true;
    } else if (idSub == 4) {
      if (userRes.user!.isBiology) return true;
    } else if (idSub == 5) {
      if (userRes.user!.isEnglish) return true;
    } else if (idSub == 6) {
      if (userRes.user!.isHistory) return true;
    } else if (idSub == 7) {
      if (userRes.user!.isGeography) return true;
    } else if (idSub == 8) {
      if (userRes.user!.isGDCD) return true;
    } else {
      if (userRes.user!.isLiterature) return true;
    }
    return false;
  }

  Future decodeHtml(List list) async {
    userRes.listAnswerResult = [];
    userRes.listQuesHive = [];
    userRes.numQuesEng = 0;
    for (int i = 0; i < list.length; i++) {
      QuestionModel model = list[i];
      model.question = unescape.convert(model.question);
      model.answer = unescape.convert(model.answer);
      model.answerA = unescape.convert(model.answerA);
      model.answerB = unescape.convert(model.answerB);
      model.answerC = unescape.convert(model.answerC);
      model.answerD = unescape.convert(model.answerD);
      model.hints = unescape.convert(model.hints);
      model.comments = unescape.convert(model.comments);
      userRes.listQuesHive.add(model);
      if (model.answerTrue != 0) {
        userRes.listAnswerResult.add(model.answerTrue);
        userRes.numQuesEng++;
      }
    }
  }

  void onActive() {
    showDialog(
      context: context,
      builder: (context) => NotifyDialogActive(onBack: onBack),
    );
  }

  void showDialogNote() {
    showDialog(
      context: context,
      builder: (context) => const NoteDialogView(),
    );
  }
}
