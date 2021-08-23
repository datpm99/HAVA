import 'package:hava/src/lib_view.dart';
import 'add_scope_presenter.dart';
import 'tab3_view.dart';
import 'tab_view.dart';

class AddScopeView extends StatefulWidget {
  final int idTran;

  const AddScopeView({Key? key, required this.idTran}) : super(key: key);

  @override
  _AddScopeViewState createState() => _AddScopeViewState();
}

class _AddScopeViewState extends State<AddScopeView>
    with SingleTickerProviderStateMixin
    implements Contract {
  late AddScopePresenter _presenter;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _presenter = AddScopePresenter(context, this);
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Điểm trung bình',
          style: Styles.appBar(color: Styles.colorB2),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: Styles.colorG5),
          const SizedBox(height: 10),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: VAll.decoR5C(Styles.colorG15),
            child: TabBar(
              controller: _controller,
              unselectedLabelColor: Styles.colorB5,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: VAll.decoR5C(Styles.colorOr4),
              tabs: const <Widget>[
                Tab(child: Center(child: Text('Học kỳ 1'))),
                Tab(child: Center(child: Text('Học kỳ 2'))),
                Tab(child: Center(child: Text('Cả năm'))),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                TabView(
                  title: 'Điểm tổng kết học kỳ 1',
                  idTran: widget.idTran,
                  term: 1,
                ),
                TabView(
                  title: 'Điểm tổng kết học kỳ 2',
                  idTran: widget.idTran,
                  term: 2,
                ),
                Tab3View(idTran: widget.idTran),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
