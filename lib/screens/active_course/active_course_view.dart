import 'active_course_presenter.dart';
import 'package:flutter/gestures.dart';
import 'package:hava/src/lib_view.dart';

class ActiveCourseView extends StatefulWidget {
  const ActiveCourseView({Key? key}) : super(key: key);

  @override
  _ActiveCourseViewState createState() => _ActiveCourseViewState();
}

class _ActiveCourseViewState extends State<ActiveCourseView>
    implements Contract {
  late ActiveCoursePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ActiveCoursePresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kích hoạt khóa học')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowFirst(),
            const SizedBox(height: 20),
            VAll.txtField(
              name: 'Nhập mã kích hoạt khóa học',
              con: _presenter.txtActive,
            ),
            const SizedBox(height: 20),
            _btnActive(),
            const SizedBox(height: 40),
            _buildRowSecond(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowFirst() {
    return Row(
      children: [
        Image.asset('assets/images/img_active.png', width: 30, height: 30),
        const SizedBox(width: 15),
        Text(
          'Kích hoạt khóa học',
          style: Styles.cusText(color: Styles.colorB2),
        ),
      ],
    );
  }

  Widget _buildRowSecond() {
    return RichText(
      text: TextSpan(
        text: 'Nếu bạn chưa có mã kích hoạt khóa học',
        style: Styles.txtBlack(size: 15, height: 1.2),
        children: <TextSpan>[
          TextSpan(
            text: ' liên hệ với chúng tôi ngay!',
            style:
                Styles.txtBlack(color: Styles.colorOr3, size: 15, height: 1.2),
            recognizer: TapGestureRecognizer()..onTap = _presenter.onContact,
          ),
        ],
      ),
    );
  }

  Widget _btnActive() {
    return Center(
      child: FlatButton(
        color: Styles.colorOr3,
        onPressed: _presenter.onActiveCourse,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text('Kích hoạt', style: Styles.copyStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
