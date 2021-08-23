import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:hava/models/history_model.dart';
import 'package:hava/src/lib_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'history_presenter.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin
    implements Contract {
  late HistoryPresenter _presenter;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _presenter = HistoryPresenter(context, this);
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch sử')),
      body: Column(
        children: [
          Container(
            width: width,
            color: Styles.colorG8,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ButtonsTabBar(
              controller: _tabController,
              backgroundColor: Styles.colorOr3,
              unselectedBackgroundColor: Styles.colorG8,
              labelStyle: Styles.copyStyle(color: Colors.white),
              unselectedLabelStyle: Styles.copyStyle(color: Styles.colorB2),
              borderWidth: 0.5,
              borderColor: Styles.colorOr3,
              unselectedBorderColor: Styles.colorG6,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              tabs: const [
                Tab(text: '   TOÁN   '),
                Tab(text: '  VẬT LÝ  '),
                Tab(text: 'HÓA HỌC'),
                Tab(text: 'SINH HỌC'),
                Tab(text: 'TIẾNG ANH'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildList(
                  _presenter.list1,
                  _presenter.itemBuilder1,
                  _presenter.controller1,
                  height,
                  _presenter.listChart1,
                ),
                _buildList(
                  _presenter.list2,
                  _presenter.itemBuilder2,
                  _presenter.controller2,
                  height,
                  _presenter.listChart2,
                ),
                _buildList(
                  _presenter.list3,
                  _presenter.itemBuilder3,
                  _presenter.controller3,
                  height,
                  _presenter.listChart3,
                ),
                _buildList(
                  _presenter.list4,
                  _presenter.itemBuilder4,
                  _presenter.controller4,
                  height,
                  _presenter.listChart4,
                ),
                _buildList(
                  _presenter.list5,
                  _presenter.itemBuilder5,
                  _presenter.controller5,
                  height,
                  _presenter.listChart5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List list, IndexedWidgetBuilder item,
      ScrollController controller, double height, List<HisChart> listHis) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height / 2 - 100,
          child: SfCartesianChart(
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<HisChart, String>>[
                LineSeries<HisChart, String>(
                    // Bind data source
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: Colors.redAccent,
                    dataSource: listHis,
                    xValueMapper: (HisChart sales, _) => '${sales.num}',
                    yValueMapper: (HisChart sales, _) => sales.point)
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Danh sách bài thi đã làm',
            style: Styles.cusText(color: Styles.colorB2),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            itemCount: list.length + 1,
            itemBuilder: item,
          ),
        ),
      ],
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
