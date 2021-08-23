import 'package:hava/src/lib_view.dart';
import 'average_presenter.dart';

class AverageView extends StatefulWidget {
  const AverageView({Key? key}) : super(key: key);

  @override
  _AverageViewState createState() => _AverageViewState();
}

class _AverageViewState extends State<AverageView> implements Contract {
  late AveragePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = AveragePresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Điểm trung bình')),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        itemCount: _presenter.list.length + 1,
        itemBuilder: _presenter.itemBuilder,
      ),
      bottomNavigationBar: VAll.btnUpdate(
        name: 'Tạo bảng mới',
        onTap: _presenter.onCreateAverage,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
