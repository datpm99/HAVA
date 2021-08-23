import 'package:hava/src/lib_view.dart';
import 'tab_presenter.dart';

class TabView extends StatefulWidget {
  final String title;
  final int idTran, term;

  const TabView(
      {Key? key, required this.title, required this.idTran, required this.term})
      : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> implements Contract {
  late TabPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = TabPresenter(context, this, widget.idTran, widget.term);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            itemCount: _presenter.list.length + 1,
            itemBuilder: _presenter.itemBuilder,
          ),
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Styles.colorG15,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: Styles.copyStyle(color: Styles.colorB5),
                ),
              ),
              Text(
                _presenter.markShow,
                style: Styles.txtBold(color: Colors.redAccent, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }
}
