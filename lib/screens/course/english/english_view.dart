import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/src/lib_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'english_presenter.dart';

class EnglishView extends StatefulWidget {
  final int idExam, isIdExam, idHis, idSchedule;
  final List listQues;

  const EnglishView(
      {Key? key,
      required this.idExam,
      required this.isIdExam,
      required this.listQues,
      required this.idHis,
      required this.idSchedule})
      : super(key: key);

  @override
  _EnglishViewState createState() => _EnglishViewState();
}

class _EnglishViewState extends State<EnglishView> implements Contract {
  late EnglishPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = EnglishPresenter(context, this, widget.listQues, widget.idExam,
        widget.isIdExam, widget.idHis, widget.idSchedule);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
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
              child: ScrollablePositionedList.builder(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                itemCount: _presenter.list.length,
                itemBuilder: _presenter.itemBuilder,
                itemScrollController: _presenter.itemScrollController,
              ),
            ),
          ],
        ),
        floatingActionButton: (widget.idHis == -1)
            ? Container()
            : VAll.fabSubject(showBottomSheet),
      ),
      onWillPop: _presenter.onWillPopBack,
    );
  }

  //Bottom Sheet.
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
          VAll.rowSheet(_presenter.onBack, '${_presenter.userRes.qsChoice}',
              '${_presenter.userRes.numQuesEng}'),
          const SizedBox(height: 15),
          Wrap(spacing: 10, runSpacing: 10, children: _buildListGen()),
          const SizedBox(height: 20),
          VAll.btnUpdate(
              name: _presenter.whenSubmit, onTap: _presenter.onSubmit),
          (_presenter.isSubmit)
              ? VAll.btnUpdate(
                  name: 'Bảng Đánh Giá', onTap: _presenter.totalResult)
              : Container(),
        ],
      ),
    );
  }

  List<Widget> _buildListGen() {
    String temp = '';
    List<GestureDetector> con =
        List<GestureDetector>.generate(_presenter.userRes.numQuesEng, (index) {
      (index < 9) ? temp = '0${index + 1}' : temp = '${index + 1}';
      return GestureDetector(
        onTap: () => _presenter.onIndexItem(index),
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

  //View widget.
  Widget _buildFirst() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          Text(
            'Môn: Tiếng Anh',
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
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
      child: Row(
        children: [
          (widget.idHis == -1)
              ? Expanded(child: Container())
              : Expanded(child: _buildBloc1()),
          (widget.isIdExam == 3)
              ? Container(height: 40, width: 10)
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
                      _buildBloc2(),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildBloc1() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is ClickQuesEngState,
      builder: (context, state) {
        return VAll.txtBloc('${_presenter.userRes.qsChoice}',
            '${_presenter.userRes.numQuesEng}');
      },
    );
  }

  Widget _buildBloc2() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is CDTimeEngState,
      builder: (context, state) {
        return Text(
          '${_presenter.minuteShow}:${_presenter.secondShow}',
          style: Styles.txtBold(size: 16, color: Colors.red),
        );
      },
    );
  }

  Widget _buildDivider3(double width) {
    return Container(width: width, height: 3, color: Styles.colorG8);
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    if (widget.idHis == 0 && widget.isIdExam != 3) _presenter.timer!.cancel();
    _presenter.audioPlayer.stop();
    _presenter.audioPlayer.dispose();
    _presenter.audioCache.clearCache();
    super.dispose();
  }
}
