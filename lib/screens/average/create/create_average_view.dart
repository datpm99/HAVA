import 'package:hava/src/lib_view.dart';
import 'create_average_presenter.dart';

class CreateAverageView extends StatefulWidget {
  const CreateAverageView({Key? key}) : super(key: key);

  @override
  _CreateAverageViewState createState() => _CreateAverageViewState();
}

class _CreateAverageViewState extends State<CreateAverageView>
    implements Contract {
  late CreateAveragePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = CreateAveragePresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return WillPopScope(
      onWillPop: _presenter.onWillPopBack,
      child: Scaffold(
        appBar: AppBar(
          leading: VAll.leadingAppbar(_presenter.onBackAverage),
          title: const Text('Tạo bảng điểm'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              VAll.sheetField(
                name: 'Nhập tên học sinh',
                txtName: _presenter.txtName,
                ver: 10.0,
                hor: 0.0,
              ),
              VAll.sheetField(
                name: 'Nhập lớp học',
                txtName: _presenter.txtClass,
                ver: 10.0,
                hor: 0.0,
              ),
              VAll.sheetField(
                name: 'Nhập câu slogan',
                txtName: _presenter.txtSlogan,
                ver: 10.0,
                hor: 0.0,
              ),
              _buildTitleSub(),
              _buildListSub(width),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Text(
                      'Các hệ số tính điểm',
                      style: Styles.cusText(color: Styles.colorG1),
                    ),
                  ],
                ),
              ),
              _buildScope(width),
              _buildBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSub() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Danh sách các môn',
              style: Styles.cusText(color: Styles.colorG1),
            ),
          ),
          GestureDetector(
            onTap: _presenter.onChangeSub,
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: VAll.decoRd5NonBr(),
              child: Text(
                'Thay đổi',
                style: Styles.txtBlack(color: Styles.colorG1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSub(width) {
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(5, 15, 15, 15),
      decoration: VAll.decoRd5NonBr(),
      child: Wrap(runSpacing: 10, children: _buildListGen()),
    );
  }

  List<Widget> _buildListGen() {
    List<Container> con =
    List<Container>.generate(_presenter.listSub.length, (index) {
      return (_presenter.listBool[index]) ? Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.only(left: 10),
        decoration: VAll.decoR5C(Styles.colorG7),
        child: Text(
          _presenter.listSub[index],
          style: Styles.txtBlack(color: Styles.colorB4),
        ),
      ) : Container(width: 0,height: 0);
    });
    return con;
  }

  Widget _buildScope(width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: VAll.decoRd5NonBr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTxt(name: '- Điểm miệng : Hệ số 1'),
          const SizedBox(height: 20),
          _buildTxt(name: '- Điểm 15 phút : Hệ số 1'),
          const SizedBox(height: 20),
          _buildTxt(name: '- Điểm 1 tiết : Hệ số 2'),
          const SizedBox(height: 20),
          _buildTxt(name: '- Điểm thi : Hệ số 3'),
        ],
      ),
    );
  }

  Widget _buildTxt({String name = ''}) {
    return Text(name, style: Styles.copyStyle(color: Styles.colorB3));
  }

  Widget _buildBtn() {
    return GestureDetector(
      onTap: _presenter.onSubmit,
      child: Container(
        height: 40,
        width: 110,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        decoration: VAll.decoRd5NonBr(),
        child: Text(
          'Hoàn tất',
          style: Styles.cusText(color: Styles.colorG1),
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
