import 'package:hava/src/lib_view.dart';
import 'course_presenter.dart';

class CourseView extends StatefulWidget {
  final String sub, img;
  final int id;

  const CourseView(
      {Key? key, required this.sub, required this.img, required this.id})
      : super(key: key);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> implements Contract {
  late CoursePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = CoursePresenter(context, this, widget.sub, widget.id);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Môn học')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(width),
            Padding(
              padding: EdgeInsets.symmetric(vertical: _presenter.userRes.velSub),
              child: Row(
                children: [
                  _buildContent1(width,height),
                  const Spacer(),
                  _buildContent(
                    width: width,
                    name: 'LUYỆN ĐỀ',
                    tap1: _presenter.onPractice,
                    tap2: _presenter.onPracticeRD,
                  ),
                ],
              ),
            ),
            _buildContent(
              width: width,
              name: 'THI THỬ',
              tap1: _presenter.onExam,
              tap2: _presenter.onExamRD,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(width) {
    return Stack(
      children: [
        Container(
          width: width,
          height: _presenter.userRes.icImg1,
          padding: const EdgeInsets.fromLTRB(10, 13, 0, 13),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 55),
            decoration: VAll.decoR5C(Styles.colorOr5),
            child: Text(widget.sub, style: Styles.cusText(size: 17)),
          ),
        ),
        Image.asset(
          widget.img,
          width: _presenter.userRes.icImg1,
          height: _presenter.userRes.icImg1,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildContent1(width, height) {
    return GestureDetector(
      onTap: _presenter.onKnowledge,
      child: Container(
        width: (width / 2) - 20,
        height: 200,
        decoration: VAll.boxImg2('assets/images/bg_course1.png'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_course1.png',
              width: (width / 2) / 2,
              height: (height/3)*0.55,
            ),
            Text(
              'KIẾN THỨC',
              style: Styles.txtBold(color: Styles.colorY2, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
      {name, double width = 0, Function()? tap1, Function()? tap2}) {
    return Container(
      width: (width / 2) - 20,
      height: 200,
      decoration: VAll.boxImg2('assets/images/bg_course1.png'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: Styles.txtBold(size: 16)),
          const SizedBox(height: 20),
          _buildBtn(
            width: (width / 2) - 65,
            img: 'assets/images/btn_course2.png',
            onTap: tap1,
          ),
          SizedBox(height: _presenter.userRes.heightBox),
          _buildBtn(
            width: (width / 2) - 65,
            img: 'assets/images/btn_course1.png',
            onTap: tap2,
          ),
        ],
      ),
    );
  }

  Widget _buildBtn({double width = 0, Function()? onTap, String img = ''}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        img,
        width: width,
        height: 35,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
