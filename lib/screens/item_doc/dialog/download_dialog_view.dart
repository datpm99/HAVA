import 'package:flutter/material.dart';
import 'package:hava/base/contract.dart';
import 'download_dialog_presenter.dart';

class DownloadDialogView extends StatefulWidget {
  final String urlPath, savePath;

  const DownloadDialogView(
      {Key? key, required this.urlPath, required this.savePath})
      : super(key: key);

  @override
  _DownloadDialogViewState createState() => _DownloadDialogViewState();
}

class _DownloadDialogViewState extends State<DownloadDialogView>
    implements Contract {
  late DownloadDialogPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter =
        DownloadDialogPresenter(context, this, widget.urlPath, widget.savePath);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Đang tải xuống... ${_presenter.progress.floor()}%'),
      content: LinearProgressIndicator(value: _presenter.value),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
