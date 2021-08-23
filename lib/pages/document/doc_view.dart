import 'package:flutter/material.dart';
import 'package:hava/base/contract.dart';
import 'doc_presenter.dart';

class DocView extends StatefulWidget {
  @override
  _DocViewState createState() => _DocViewState();
}

class _DocViewState extends State<DocView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late DocPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DocPresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tài liệu')),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _presenter.list.length + 1,
        itemBuilder: _presenter.itemBuilder,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
