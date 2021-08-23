import 'guide_presenter.dart';
import 'package:flutter/services.dart';
import 'package:hava/src/lib_view.dart';

class GuideView extends StatefulWidget {
  const GuideView({Key? key}) : super(key: key);

  @override
  _GuideViewState createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> implements Contract {
  late GuidePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GuidePresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hướng dẫn')),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
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
  void dispose() {
    _presenter.controllerYT.close();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
