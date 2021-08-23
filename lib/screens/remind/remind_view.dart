import 'package:hava/src/lib_view.dart';
import 'remind_presenter.dart';

class RemindView extends StatefulWidget {
  const RemindView({Key? key}) : super(key: key);

  @override
  _RemindViewState createState() => _RemindViewState();
}

class _RemindViewState extends State<RemindView> implements Contract {
  RemindPresenter? _presenter;

  @override
  void initState() {
    _presenter = RemindPresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter!.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nhắc nhở')),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 5),
        physics: const BouncingScrollPhysics(),
        itemBuilder: _presenter!.itemBuilder,
        itemCount: _presenter!.list.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _presenter!.addReminder,
        backgroundColor: Styles.colorMain,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
