import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/src/lib_view.dart';
import 'gold_board_presenter.dart';

class GoldBoardView extends StatefulWidget {
  const GoldBoardView({Key? key}) : super(key: key);

  @override
  _GoldBoardViewState createState() => _GoldBoardViewState();
}

class _GoldBoardViewState extends State<GoldBoardView> implements Contract {
  late GoldBoardPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GoldBoardPresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đấu trường thi')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                Image.asset('assets/images/bg_exam.png', height: 160),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 84),
                    child: _timeExam(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 40),
              itemCount: _presenter.list.length,
              itemBuilder: _presenter.itemBuilder,
            ),
          )
        ],
      ),
    );
  }

  Widget _timeExam() {
    return Container(
      width: 200,
      height: 50,
      decoration: VAll.boxImg2('assets/images/bg_time.png'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_presenter.titleSub, style: Styles.cusText(size: 12)),
          const SizedBox(height: 2),
          _timeExamBloc(),
        ],
      ),
    );
  }

  Widget _timeExamBloc() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is CDDetailScheduleState,
      builder: (context, state) {
        return Text(
          '${_presenter.dayShow} ngày - ${_presenter.hourShow} giờ - ${_presenter.minuteShow} phút - ${_presenter.secondShow} giây',
          style: Styles.cusText(size: 10, color: Styles.colorY1),
        );
      },
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    if (!_presenter.isCancelTime) _presenter.myTimer!.cancel();
    super.dispose();
  }
}
