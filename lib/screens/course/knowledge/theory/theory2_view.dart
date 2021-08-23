import 'package:flutter_html/flutter_html.dart';
import 'package:hava/src/lib_view.dart';
import 'theory2_presenter.dart';

class Theory2View extends StatefulWidget {
  final int id;

  const Theory2View({Key? key, required this.id}) : super(key: key);

  @override
  _Theory2ViewState createState() => _Theory2ViewState();
}

class _Theory2ViewState extends State<Theory2View> implements Contract {
  late Theory2Presenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = Theory2Presenter(context, this, widget.id);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kiến thức')),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Html(data: _presenter.content),
          ),
          (_presenter.isLoading) ? _presenter.loadingView() : Container(),
        ],
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
