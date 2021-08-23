import 'package:hava/src/lib_view.dart';
import 'lesson_presenter.dart';

class LessonView extends StatefulWidget {
  final String sub, title;
  final List listKnow;
  final int idSub;

  const LessonView(
      {Key? key,
      required this.sub,
      required this.title,
      required this.listKnow,
      required this.idSub})
      : super(key: key);

  @override
  _LessonViewState createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> implements Contract {
  late LessonPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LessonPresenter(
        context, this, widget.listKnow, widget.sub, widget.idSub);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sub)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.title,
              style: Styles.cusText(color: Styles.colorB2, size: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _presenter.list.length,
              itemBuilder: _presenter.itemBuilder,
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
