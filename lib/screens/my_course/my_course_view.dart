import 'package:hava/src/lib_view.dart';
import 'item_nothing_course.dart';
import 'my_course_presenter.dart';

class MyCourseView extends StatefulWidget {
  final bool isMyCourse;

  const MyCourseView({Key? key, required this.isMyCourse}) : super(key: key);

  @override
  _MyCourseViewState createState() => _MyCourseViewState();
}

class _MyCourseViewState extends State<MyCourseView> implements Contract {
  late MyCoursePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = MyCoursePresenter(context, this, widget.isMyCourse);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Khóa học của tôi')),
      body: Column(
        children: [
          Visibility(
            visible: (!widget.isMyCourse),
            child: const ItemNothingCourse(),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: (widget.isMyCourse)
                  ? _presenter.list.length + 1
                  : _presenter.list.length,
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
