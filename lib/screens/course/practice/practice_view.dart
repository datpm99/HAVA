import 'package:hava/src/lib_view.dart';
import 'package:hava/auth/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'practice_presenter.dart';

class PracticeView extends StatefulWidget {
  final int idExam, isIdExam, idHis, idSchedule, idSub;
  final List listQuestion;
  final String nameSubject, timeSub;

  const PracticeView({
    Key? key,
    required this.idExam,
    required this.listQuestion,
    required this.isIdExam,
    required this.nameSubject,
    required this.timeSub,
    required this.idHis,
    required this.idSchedule,
    required this.idSub,
  }) : super(key: key);

  @override
  _PracticeViewState createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView>
    with SingleTickerProviderStateMixin
    implements Contract {
  late PracticePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = PracticePresenter(
      context,
      this,
      widget.idExam,
      widget.listQuestion,
      widget.isIdExam,
      widget.timeSub,
      widget.nameSubject,
      widget.idHis,
      widget.idSchedule,
      widget.idSub,
    );
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
    _presenter.tabController =
        TabController(vsync: this, length: widget.listQuestion.length);
    _presenter.tabController!.addListener(() {
      _presenter.indexTab = _presenter.tabController!.index;
      BlocProvider.of<AuthBloc>(context).add(ClickTabBarEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
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
            _buildThird(),
            Expanded(child: _blocTabBar()),
          ],
        ),
        floatingActionButton: (widget.idHis == -1)
            ? Container()
            : VAll.fabSubject(showBottomSheet),
      ),
      onWillPop: _presenter.onWillPopBack,
    );
  }

  //BottomSheet.
  void showBottomSheet() {
    showModalBottomSheet(
      shape: VAll.shapeSheet(),
      context: context,
      builder: (context) => _buildSheet(),
    );
  }

  Widget _buildSheet() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          VAll.rowSheet(
            _presenter.onBack,
            '${_presenter.userRes.qsChoice}',
            '${widget.listQuestion.length}',
          ),
          const SizedBox(height: 15),
          Wrap(spacing: 10, runSpacing: 10, children: _buildListGen()),
          const SizedBox(height: 20),
          VAll.btnUpdate(
              name: _presenter.whenSubmit, onTap: _presenter.onSubmit),
          (_presenter.isSubmit)
              ? VAll.btnUpdate(
                  name: 'Bảng Tổng Kết', onTap: _presenter.totalResult)
              : Container(),
        ],
      ),
    );
  }

  List<Widget> _buildListGen() {
    String temp = '';
    List<GestureDetector> con =
        List<GestureDetector>.generate(widget.listQuestion.length, (index) {
      (index < 9) ? temp = '0${index + 1}' : temp = '${index + 1}';
      return GestureDetector(
        onTap: () => _presenter.onTapQuestion(index),
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration:
              (_presenter.isSubmit) ? decoSubmit(index) : decoChoice(index),
          child: Text(temp, style: Styles.copyStyle(color: Colors.white)),
        ),
      );
    });
    return con;
  }

  Decoration decoChoice(int index) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: (_presenter.userRes.listAnswerExe[index] != 0)
          ? Styles.colorGreen1
          : Styles.colorG5,
    );
  }

  Decoration decoSubmit(int index) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: (_presenter.userRes.listAnswerExe[index] ==
              _presenter.userRes.listAnswerResult[index])
          ? Styles.colorGreen1
          : Colors.redAccent,
    );
  }

  //View Widget.
  Widget _buildFirst() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          Text(
            'Môn: ${widget.nameSubject}',
            style: Styles.cusText(color: Styles.colorB2, size: 16),
          ),
          const Spacer(),
          (widget.isIdExam == 3)
              ? Container()
              : Text(
                  'Mã Đề: ${widget.idExam}',
                  style: Styles.copyStyle(color: Styles.colorG2),
                ),
        ],
      ),
    );
  }

  Widget _buildSecond() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
      child: Row(
        children: [
          (widget.idHis == -1)
              ? Expanded(child: Container())
              : Expanded(child: _buildBloc1()),
          (widget.isIdExam == 3)
              ? const SizedBox(height: 30, width: 10)
              : Container(
                  height: 40,
                  width: 90,
                  decoration: VAll.decoCR2(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/ic_clock.png',
                          width: 20, height: 20),
                      const SizedBox(width: 5),
                      _buildBloc2()
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildBloc1() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is ClickQuestionState,
      builder: (context, state) {
        return VAll.txtBloc(
            '${_presenter.userRes.qsChoice}', '${widget.listQuestion.length}');
      },
    );
  }

  Widget _buildBloc2() {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is CountDownTimeState,
        builder: (context, state) {
          return Text(
            '${_presenter.minuteShow}:${_presenter.secondShow}',
            style: Styles.txtBold(size: 16, color: Colors.red),
          );
        });
  }

  //AppBar.
  Widget _btnTab(String img, Function() onTap) {
    return GestureDetector(
      child: Image.asset(img, width: 40, height: 40),
      onTap: onTap,
    );
  }

  Widget _buildThird() {
    return Container(
      color: Styles.colorG7,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          _btnTab('assets/icons/trai.png', _presenter.onBackTab),
          const Spacer(),
          _blocTxtTab(),
          Text(
            '/${widget.listQuestion.length}',
            style: Styles.txtBold(color: Styles.colorB2, size: 15),
          ),
          const Spacer(),
          _btnTab('assets/icons/phai.png', _presenter.onNextTab),
        ],
      ),
    );
  }

  Widget _blocTxtTab() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is ClickTabBarState,
      builder: (context, state) {
        return Text(
          'Câu ${_presenter.indexTab + 1}',
          style: Styles.txtBold(color: Styles.colorRed3, size: 15),
        );
      },
    );
  }

  Widget _blocTabBar() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is ClickTabBarState,
      builder: (context, state) {
        return TabBarView(
          controller: _presenter.tabController,
          children: (_presenter.isSubmit)
              ? _presenter.listTab2()
              : _presenter.buildListTab(),
        );
      },
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    if (widget.idHis == 0 && widget.isIdExam != 3) _presenter.timer!.cancel();
    _presenter.controllerCenter.dispose();
    super.dispose();
  }
}
