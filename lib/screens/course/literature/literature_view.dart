import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/src/lib_view.dart';
import 'literature_presenter.dart';

class LiteratureView extends StatefulWidget {
  final int idExam;
  final List listQuestion;
  final int isIdExam;

  const LiteratureView(
      {Key? key,
      required this.idExam,
      required this.listQuestion,
      required this.isIdExam})
      : super(key: key);

  @override
  _LiteratureViewState createState() => _LiteratureViewState();
}

class _LiteratureViewState extends State<LiteratureView> implements Contract {
  late LiteraturePresenter _presenter;

  @override
  void initState() {
    _presenter = LiteraturePresenter(
        context, this, widget.listQuestion, widget.isIdExam);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: VAll.leadingAppbar(_presenter.onBackExam),
          title: Text(_presenter.titleAppbar),
          actions: [VAll.btnNote(_presenter.showDialogNote)],
        ),
        body: Column(
          children: [
            _buildFirst(),
            const Divider(height: 1, color: Styles.colorG10),
            _buildSecond(),
            _buildDivider3(width),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 80),
                itemCount: _presenter.list.length,
                itemBuilder: _presenter.itemBuilder,
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Visibility(
          visible: !_presenter.isSubmit,
          child: FloatingActionButton.extended(
            backgroundColor: Styles.colorMain,
            onPressed: _presenter.onSubmit,
            label: const Text('Lời Giải'),
          ),
        ),
      ),
      onWillPop: _presenter.onWillPopBack,
    );
  }

  Widget _buildDivider3(double width) {
    return Container(width: width, height: 3, color: Styles.colorG8);
  }

  Widget _buildFirst() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          Text(
            'Môn: Ngữ Văn',
            style: Styles.cusText(color: Styles.colorB2, size: 16),
          ),
          const Spacer(),
          Text(
            'Mã Đề: ${widget.idExam}',
            style: Styles.copyStyle(color: Styles.colorG2),
          ),
        ],
      ),
    );
  }

  Widget _buildSecond() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 5, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'Đề có',
              style: Styles.txtBold(color: Styles.colorB2),
              children: <TextSpan>[
                TextSpan(
                  text: ' ${_presenter.numQues} ',
                  style:
                      const TextStyle(color: Styles.colorGreen1, fontSize: 16),
                ),
                const TextSpan(text: 'câu hỏi'),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 90,
            alignment: Alignment.center,
            decoration: VAll.decoCR2(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/ic_clock.png', width: 20, height: 20),
                const SizedBox(width: 5),
                _buildBloc2()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBloc2() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Text(
        '${_presenter.minuteShow}:${_presenter.secondShow}',
        style: Styles.txtBold(size: 16, color: Colors.red),
      );
    });
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _presenter.timer!.cancel();
    super.dispose();
  }
}
